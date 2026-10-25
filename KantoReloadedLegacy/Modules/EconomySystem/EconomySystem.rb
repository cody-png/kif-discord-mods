#==============================================================================
# Kanto Reloaded - Economy System
#==============================================================================
# Kanto Reloaded Legacy keeps Starting Money, Battle Money and the Reloaded
# PC's paid services. Mart Events and the Economy System master switch were
# dropped (2026-10-22): each feature here has its own switch.
#==============================================================================

module KantoReloaded
  module EconomySystem
    SETTINGS_ACTION = :economy_system_settings
    STARTING_MONEY_VALUE = :economy_starting_money
    BATTLE_MONEY_SETTING = :economy_battle_money_enabled
    BATTLE_MONEY_VALUE = :economy_battle_money_multiplier
    RESET_EV_SETTING = :economy_reset_evs
    RESET_EV_PRICE = :economy_reset_evs_price
    FRIENDSHIP_SETTING = :economy_friendship_boost
    FRIENDSHIP_PRICE = :economy_friendship_price

    class << self
      def install
        return true if @installed
        settings = register_settings
        hooks = register_hooks
        actions = register_pc_actions
        @installed = settings && hooks && actions
        KantoReloaded::Log.info(
          "Economy System installed settings=#{settings} hooks=#{hooks} " +
          "pc=#{actions}",
          :modules
        ) if defined?(KantoReloaded::Log)
        @installed
      rescue StandardError => e
        KantoReloaded::Log.exception(
          "Economy System installation failed", e, :channel => :economy_system
        ) if defined?(KantoReloaded::Log)
        false
      end

      def reset_ev_price
        setting(RESET_EV_PRICE, 1000).to_i
      end

      def friendship_price
        setting(FRIENDSHIP_PRICE, 5000).to_i
      end

      private

      def register_settings
        return false unless defined?(KantoReloaded::Settings)
        action = KantoReloaded::Settings.register(SETTINGS_ACTION, {
          :name => "Economy System",
          :description => "Configure money progression and paid services.",
          :type => :button, :category => :economy,
          :owner => :kanto_reloaded, :priority => 1000,
          :on_press => proc {
            KantoReloaded::SettingsUI.open_module(
              :economy_system, :title => "Economy System"
            )
          }
        })
        visible = proc do |context|
          value = context.is_a?(Hash) &&
            (context[:module] || context["module"] || context[:owner] || context["owner"])
          value && value.to_sym == :economy_system
        rescue StandardError
          false
        end
        rows = [
          [STARTING_MONEY_VALUE, "Starting Money", "Set the money assigned to a newly created Trainer.", :number, 3000, 100, {
            :min => 0, :max => 9999999, :step => 100, :scope => :global,
            :metadata => {
              :popup_picker => true, :digits => 7,
              :picker_label => "New-game money", :value_prefix => "$"
            }
          }],
          [BATTLE_MONEY_SETTING, "Battle Money", "Apply a multiplier to native battle payouts.", :toggle, 1, 120, {}],
          [BATTLE_MONEY_VALUE, "Battle Multiplier", "Multiply the money awarded by the completed native payout.", :number, 1, 130, { :min => 1, :max => 10, :step => 1, :enabled_if => proc { toggle(BATTLE_MONEY_SETTING, true) } }],
          [RESET_EV_SETTING, "Reset EVs", "Offer a paid EV reset action in Reloaded PC.", :toggle, 1, 200, {}],
          [RESET_EV_PRICE, "Reset EV Price", "Set the price of the Reloaded PC EV reset service.", :number, 1000, 210, {
            :min => 0, :max => 999999, :step => 100,
            :enabled_if => proc { toggle(RESET_EV_SETTING, true) },
            :metadata => {
              :popup_picker => true, :digits => 6,
              :picker_label => "EV reset price", :value_prefix => "$"
            }
          }],
          [FRIENDSHIP_SETTING, "Friendship Boost", "Offer a paid +50 friendship action in Reloaded PC.", :toggle, 1, 220, {}],
          [FRIENDSHIP_PRICE, "Friendship Price", "Set the price of the Reloaded PC friendship service.", :number, 5000, 230, {
            :min => 0, :max => 999999, :step => 100,
            :enabled_if => proc { toggle(FRIENDSHIP_SETTING, true) },
            :metadata => {
              :popup_picker => true, :digits => 6,
              :picker_label => "Friendship service price", :value_prefix => "$"
            }
          }]
        ]
        created = rows.map do |key, name, description, type, default, priority, extra|
          KantoReloaded::Settings.register(key, {
            :name => name, :description => description, :type => type,
            :default => default, :priority => priority,
            :category => :economy, :owner => :economy_system,
            :value_style => :integer, :visible_if => visible
          }.merge(extra))
        end
        !action.nil? && created.all? { |entry| !entry.nil? }
      end

      def register_hooks
        return false unless defined?(KantoReloaded::Hooks)
        results = []
        if defined?(Game) && Game.respond_to?(:start_new)
          results << KantoReloaded::Hooks.wrap(
            Game, :start_new, :economy_starting_money, :singleton => true
          ) do |hook, *arguments|
            result = hook.call(*arguments)
            KantoReloaded::EconomySystem.send(:apply_starting_money)
            result
          end
        end
        if defined?(PokeBattle_Battle)
          results << KantoReloaded::Hooks.wrap(
            PokeBattle_Battle, :pbGainMoney, :economy_battle_money
          ) do |hook, *arguments|
            before = (pbPlayer.money.to_i rescue 0)
            result = hook.call(*arguments)
            KantoReloaded::EconomySystem.send(
              :apply_battle_money_bonus, self, before
            )
            result
          end
        end
        !results.empty? && results.all?
      end

      def register_pc_actions
        return true unless defined?(KantoReloaded::PCOrganization)
        return false unless KantoReloaded::PCOrganization.respond_to?(:register_pokemon_action)
        reset = KantoReloaded::PCOrganization.register_pokemon_action(
          :economy_reset_evs,
          :label => _INTL("Reset EVs"), :priority => 410,
          :group => :reloaded_actions,
          :group_label => _INTL("Reloaded Actions"), :group_priority => 100,
          :return_to_group => true,
          :enabled => proc { |_access, pokemon, _locations| reset_ev_available?(pokemon) }
        ) do |scene, pokemon, _locations|
          perform_reset_evs(scene, pokemon)
        end
        friendship = KantoReloaded::PCOrganization.register_pokemon_action(
          :economy_friendship_boost,
          :label => _INTL("Friendship Boost"), :priority => 420,
          :group => :reloaded_actions,
          :group_label => _INTL("Reloaded Actions"), :group_priority => 100,
          :return_to_group => true,
          :enabled => proc { |_access, pokemon, _locations| friendship_available?(pokemon) }
        ) do |scene, pokemon, _locations|
          perform_friendship_boost(scene, pokemon)
        end
        reset && friendship
      rescue StandardError => e
        KantoReloaded::Log.exception(
          "Economy PC actions failed", e, :channel => :economy_system
        ) if defined?(KantoReloaded::Log)
        false
      end

      def apply_starting_money
        return false unless defined?($Trainer) && $Trainer
        $Trainer.money = setting(STARTING_MONEY_VALUE, 3000).to_i
        true
      rescue StandardError
        false
      end

      def apply_battle_money_bonus(battle, before)
        return 0 unless toggle(BATTLE_MONEY_SETTING, true)
        multiplier = setting(BATTLE_MONEY_VALUE, 1).to_i
        return 0 if multiplier <= 1
        player = battle.send(:pbPlayer) rescue nil
        return 0 unless player
        native_gain = player.money.to_i - before.to_i
        return 0 if native_gain <= 0
        old_money = player.money.to_i
        player.money += native_gain * (multiplier - 1)
        bonus = player.money.to_i - old_money
        battle.send(
          :pbDisplayPaused,
          _INTL("Economy bonus: ${1}!", bonus.to_i.to_s_formatted)
        ) if bonus > 0
        bonus
      rescue StandardError => e
        KantoReloaded::Log.exception(
          "Battle money bonus failed", e, :channel => :economy_system
        ) if defined?(KantoReloaded::Log)
        0
      end

      def reset_ev_available?(pokemon)
        return false unless toggle(RESET_EV_SETTING, true)
        return false unless pokemon && !(pokemon.egg? rescue false)
        values = pokemon.ev rescue {}
        values.respond_to?(:values) && values.values.any? { |value| value.to_i > 0 }
      rescue StandardError
        false
      end

      def friendship_available?(pokemon)
        toggle(FRIENDSHIP_SETTING, true) && pokemon &&
          !(pokemon.egg? rescue false) && pokemon.happiness.to_i < 255
      rescue StandardError
        false
      end

      def perform_reset_evs(scene, pokemon)
        price = reset_ev_price
        return insufficient_money if trainer_money < price
        return false unless KantoReloaded::PopupWindow.confirm(
          _INTL("Reset every EV on {1} for ${2}?", pokemon.name,
                price.to_i.to_s_formatted), :default => true
        )
        snapshot = Marshal.load(Marshal.dump(pokemon.ev)) rescue pokemon.ev.dup
        saved_snapshot = if pokemon.respond_to?(:saved_ev) && pokemon.saved_ev
                           Marshal.load(Marshal.dump(pokemon.saved_ev)) rescue pokemon.saved_ev.dup
                         end
        pokemon.ev.each_key { |stat| pokemon.ev[stat] = 0 }
        pokemon.saved_ev.each_key { |stat| pokemon.saved_ev[stat] = 0 } if
          pokemon.respond_to?(:saved_ev) && pokemon.saved_ev.respond_to?(:each_key)
        pokemon.calc_stats if pokemon.respond_to?(:calc_stats)
        return rollback_evs(pokemon, snapshot, saved_snapshot) unless charge(price)
        refresh_pc(scene)
        KantoReloaded::Toast.success(_INTL("{1}'s EVs were reset.", pokemon.name))
        true
      rescue StandardError => e
        KantoReloaded::Log.exception("EV reset service failed", e,
          :channel => :economy_system) if defined?(KantoReloaded::Log)
        false
      end

      def perform_friendship_boost(scene, pokemon)
        price = friendship_price
        return insufficient_money if trainer_money < price
        old = pokemon.happiness.to_i
        boosted = [old + 50, 255].min
        return false unless KantoReloaded::PopupWindow.confirm(
          _INTL(
            "{1}'s friendship is {2}/255 (after: {3}/255).\nApply the boost for ${4}?",
            pokemon.name, old, boosted, price.to_i.to_s_formatted
          ), :default => true
        )
        pokemon.happiness = boosted
        unless charge(price)
          pokemon.happiness = old
          return false
        end
        refresh_pc(scene)
        KantoReloaded::Toast.success(
          _INTL("{1}'s friendship rose to {2}.", pokemon.name, pokemon.happiness)
        )
        true
      rescue StandardError => e
        KantoReloaded::Log.exception("Friendship service failed", e,
          :channel => :economy_system) if defined?(KantoReloaded::Log)
        false
      end

      def rollback_evs(pokemon, snapshot, saved_snapshot = nil)
        snapshot.each { |stat, value| pokemon.ev[stat] = value }
        if saved_snapshot && pokemon.respond_to?(:saved_ev) && pokemon.saved_ev
          saved_snapshot.each { |stat, value| pokemon.saved_ev[stat] = value }
        end
        pokemon.calc_stats if pokemon.respond_to?(:calc_stats)
        false
      end

      def refresh_pc(scene)
        scene.kr_refresh if scene && scene.respond_to?(:kr_refresh)
      rescue StandardError
        nil
      end

      def insufficient_money
        KantoReloaded::PopupWindow.message(
          _INTL("You don't have enough money."), :theme => :error
        )
        false
      end

      def charge(amount)
        return false unless defined?($Trainer) && $Trainer
        return false if $Trainer.money.to_i < amount.to_i
        $Trainer.money -= amount.to_i
        true
      end

      def trainer_money
        defined?($Trainer) && $Trainer ? $Trainer.money.to_i : 0
      end

      def setting(key, fallback)
        KantoReloaded::Settings.get(key, fallback)
      rescue StandardError
        fallback
      end

      def toggle(key, fallback)
        value = setting(key, fallback ? 1 : 0)
        value == true || value.to_i == 1
      rescue StandardError
        fallback
      end
    end
  end
end

KantoReloaded::EconomySystem.install
