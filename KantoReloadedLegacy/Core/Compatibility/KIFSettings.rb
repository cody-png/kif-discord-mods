#==============================================================================
# Kanto Reloaded Legacy - KIF Settings
#==============================================================================
# KIF replaced the game's Options with KIF Settings, so Legacy's settings
# live there: one "KR Legacy" section in the sidebar with a heading per
# feature (his call, 2026-10-22). Each row is one of PIF's own option types
# reading and writing Legacy's settings registry, so stored values stay
# where they always were. A row that only matters while another is On sits
# under it and hides while it's Off (KIF's child rows: a name starting with
# a space). Loaded last, after every feature has registered its settings.
#==============================================================================

module KantoReloaded
  module KIFSettings
    SECTION = :kr_legacy
    LABEL = "KR Legacy"
    COLOUR = [170, 60, 90]

    # [heading, [[key, [child keys]], ...]]
    LAYOUT = [
      ["Overworld", [
        ["overworld_menu"], ["healing_overworld_moves"], ["miscmods_infinite_repel"],
        ["auto_hook_fishing"], ["infinite_safari_steps"]]],
      ["Wild Link", [
        ["wild_link.continue_search"], ["wild_link.sprites"], ["wild_link.messages"],
        ["wild_link_reset_search_levels"]]],
      ["Weather", [
        ["weather_system.enabled", ["weather_system.selection", "weather_system.interval",
                                    "weather_system.battle_weather", "weather_system.alerts",
                                    "weather_system.custom_audio", "weather_system.rain_audio",
                                    "weather_system.thunder_audio"]],
        ["weather_open_forecast"]]],
      ["PokeVial", [
        ["poke_vial_enabled", ["poke_vial_progressive", "poke_vial_max_uses", "poke_vial_heal_mode",
                               "poke_vial_cooldown", "poke_vial_cooldown_time", "poke_vial_refill_mode",
                               "poke_vial_refill_cost", "poke_vial_cost_per_charge"]]]],
      ["Money", [
        ["economy_starting_money"], ["economy_battle_money_enabled", ["economy_battle_money_multiplier"]],
        ["infinite_money"], ["reset_money"], ["rematch_money"]]],
      ["Shops", [
        ["reloaded_shop_regular_mart"], ["reloaded_shop_confirm_purchases"], ["reloaded_shop_edit"],
        ["reloaded_shop_export"], ["reloaded_shop_import"], ["reloaded_shop_reset"]]],
      ["PC", [
        ["pc_organization", ["pc_organization_icons"]],
        ["economy_reset_evs", ["economy_reset_evs_price"]],
        ["economy_friendship_boost", ["economy_friendship_price"]]]],
      ["Bag", [
        ["autosort_bag_enabled", ["autosort_bag_always_move_recent"]], ["autosort_bag_manual_button"],
        ["autosort_bag_mode_items"], ["autosort_bag_mode_medicine"], ["autosort_bag_mode_pok_balls"],
        ["autosort_bag_mode_tms_hms"], ["autosort_bag_mode_berries"], ["autosort_bag_mode_mail"],
        ["autosort_bag_mode_battle_items"], ["autosort_bag_mode_key_items"], ["autosort_bag_sort_all"],
        ["autosort_bag_lists"], ["autosort_bag_export"], ["autosort_bag_import"]]],
      ["Trainers", [
        ["trainer_control_level_scaling", ["trainer_control_level_reference", "trainer_control_level_offset",
                                           "trainer_control_preserve_level_spread", "trainer_control_scale_regular",
                                           "trainer_control_scale_leaders", "trainer_control_scale_rematches"]],
        ["trainer_control_expansion_mode", ["trainer_control_expansion_size_mode", "trainer_control_expansion_add_count",
                                            "trainer_control_expansion_target_size", "trainer_control_expansion_held_items"]],
        ["trainer_control_adaptation"], ["trainer_control_progression_rewards"]]],
      ["Pink Slips and Records", [
        ["trainer_control_pink_slips", ["trainer_control_pink_slips_repeat"]],
        ["trainer_control_claim_pending"],
        ["trainer_control_battle_records", ["trainer_control_record_toast", "trainer_control_record_regular",
                                            "trainer_control_record_leaders", "trainer_control_record_rematches"]],
        ["trainer_control_view_records"], ["trainer_control_reset_records"]]],
      ["Battles", [["always_obey"], ["infinite_pp"], ["upgraded_pp"]]],
      ["EBDX", [
        ["battle_ui.reloaded_ebdx_cursor"],
        ["move_effectiveness.enabled", ["move_effectiveness.quad_color", "move_effectiveness.super_color",
                                        "move_effectiveness.resisted_color", "move_effectiveness.quarter_color"]],
        # the Reloaded EBDX Cursor is drawn in this color too, so it stays
        # shown while Effectiveness Borders is Off
        ["move_effectiveness.neutral_color"]]],
      ["Levels", [["level_up_move_learning"], ["level_lock_manager"], ["super_candy"]]],
      ["Critical EV Gain", [
        ["critical_ev_gain", ["critical_ev_mode", "critical_ev_chance", "critical_ev_amount",
                              "critical_ev_show_message", "critical_ev_stat_hp", "critical_ev_stat_attack",
                              "critical_ev_stat_defense", "critical_ev_stat_special_attack",
                              "critical_ev_stat_special_defense", "critical_ev_stat_speed"]]]],
      ["Fusion", [["double_abilities"]]],
      ["Eggs and Natures", [["instant_hatch"], ["egg_manager"], ["nature_selector"]]],
      ["Look", [["ui.cursor_theme"]]]
    ].freeze

    # Names shown other than the registry's
    NAMES = {
      "move_effectiveness.enabled" => "Effectiveness Borders",   # cody's "Move Effectiveness" is KIF's
      "battle_ui.reloaded_ebdx_cursor" => "Reloaded EBDX Cursor", # registered only with EBDX's classes
      "critical_ev_stat_hp" => "HP",
      "autosort_bag_mode_pok_balls" => "Poké Balls"
    }.freeze

    # Number rows wider than this are sliders
    NUMBER_SPAN = 200

    # Mixed into Legacy's rows: the setting they show and its default
    module LegacyOption
      attr_accessor :krl_key, :krl_default
    end

    class << self
      def boot
        return true if @booted
        unless defined?(::KIF::Options) && defined?(::KIF::SettingsScreen::SECTIONS)
          KantoReloaded::Log.info("KIF Settings isn't here; Legacy's rows weren't added", :settings) if defined?(KantoReloaded::Log)
          return true
        end
        define_option_classes
        register_buttons
        ::KIF::Options.register_menu(SECTION, LABEL, "Kanto Reloaded Legacy's settings.",
                                     Color.new(248, 248, 248), Color.new(64, 64, 64), LABEL)
        add_rows
        place_section
        hook_defaults
        @booted = true
      rescue StandardError => e
        KantoReloaded::Log.exception("KIF Settings rows failed", e, channel: :settings) if defined?(KantoReloaded::Log)
        false
      end

      # The KIF option for a setting (nil while its feature isn't loaded)
      def option_for(key, name)
        d = KantoReloaded::Settings.definition(key)
        return nil unless d
        s = KantoReloaded::Settings
        desc = _INTL(d[:description].to_s)
        min = (d[:minimum] || 0).to_i
        max = (d[:maximum] || min).to_i
        option = case d[:type]
                 when :toggle
                   LegacyEnum.new(name, [_INTL("Off"), _INTL("On")], proc { truthy?(s.get(key, d[:default])) ? 1 : 0 },
                                  proc { |v| s.set(key, v.to_i == 1) }, desc)
                 when :enum
                   LegacyEnum.new(name, Array(d[:values]).map { |v| _INTL(v) }, proc { s.get(key, d[:default]).to_i },
                                  proc { |v| s.set(key, v.to_i) }, desc)
                 when :number, :slider
                   if d[:type] == :number && max - min <= NUMBER_SPAN
                     LegacyNumber.new(name, min, max, proc { s.get(key, d[:default]).to_i - min },
                                      proc { |v| s.set(key, v.to_i + min) }, desc)
                   else
                     step = [(d[:step] || 1).to_i, 1].max
                     LegacySlider.new(name, min, max, step, proc { s.get(key, d[:default]).to_i - min },
                                      proc { |v| s.set(key, v.to_i + min) }, desc)
                   end
                 when :button
                   LegacyButton.new(name, proc { s.activate(key) }, desc)
                 end
        return nil unless option
        option.krl_key = key
        option.krl_default = default_for(d, min)
        option
      end

      def display_name(key)
        return _INTL(NAMES[key]) if NAMES[key]
        d = KantoReloaded::Settings.definition(key)
        d ? _INTL(d[:name].to_s) : key.to_s
      end

      private

      def define_option_classes
        return if const_defined?(:LegacyEnum, false)
        const_set(:LegacyEnum, Class.new(::EnumOption) { include LegacyOption })
        const_set(:LegacyNumber, Class.new(::NumberOption) { include LegacyOption })
        const_set(:LegacySlider, Class.new(::SliderOption) { include LegacyOption })
        const_set(:LegacyButton, Class.new(::ButtonOption) { include LegacyOption })
      end

      # One builder per row, parents before their children (KIF hangs a row
      # whose name starts with a space under the row before it)
      def add_rows
        @names = {}
        taken = kif_names
        LAYOUT.each do |heading, rows|
          rows.each do |key, children|
            name = display_name(key)
            name = "#{name} (#{heading})" if taken.include?(name) || @names.value?(name)
            @names[key] = name
            add_builder(key) { option_for(key, name) }
            Array(children).each do |child|
              add_builder(child) { parent_shown?(key) ? option_for(child, " " + display_name(child)) : nil }
            end
          end
        end
      end

      # KIF leaves a per-save row out until a save is loaded, and would hang
      # its children under the row before it (Weather's audio under Wild
      # Link); a child is shown only with its parent
      def parent_shown?(key)
        d = KantoReloaded::Settings.definition(key)
        return false unless d
        d[:scope] == :global || !!(::KIF.in_game? rescue false)
      end

      def add_builder(key, &builder)
        d = KantoReloaded::Settings.definition(key)
        scope = d && d[:scope] == :global ? :global : :save
        ::KIF::Options.add(SECTION, scope, &builder)
      end

      # The section, first in the sidebar; a name made unique shows plainly
      def place_section
        renames = ::KIF::SettingsScreen.const_defined?(:RENAMES) ? ::KIF::SettingsScreen::RENAMES : nil
        headings = LAYOUT.map do |heading, rows|
          names = rows.map do |key, _children|
            renames[@names[key]] = display_name(key) if renames && @names[key] != display_name(key)
            @names[key]
          end
          [heading, names]
        end
        sections = ::KIF::SettingsScreen::SECTIONS
        entry = [SECTION, LABEL, COLOUR, headings]
        index = sections.index { |s| s[0] == SECTION }
        index ? sections[index] = entry : sections.insert(0, entry)
      end

      # Every name KIF's own sections place
      def kif_names
        names = []
        ::KIF::SettingsScreen::SECTIONS.each do |id, _label, _colour, groups|
          next if id == SECTION
          Array(groups).each { |_heading, list| names.concat(Array(list)) }
        end
        if ::KIF::SettingsScreen.const_defined?(:DESCRIPTIONS)
          names.concat(::KIF::SettingsScreen::DESCRIPTIONS.keys.map(&:to_s))
        end
        names
      rescue StandardError
        []
      end

      # KIF only knows defaults of PokemonSystem settings; Legacy's rows
      # give theirs (the changed dot, Z to reset, the DEFAULT pill)
      def hook_defaults
        return unless ::KIF::SettingsScreen.respond_to?(:defaults_for)
        KantoReloaded::Hooks.wrap(::KIF::SettingsScreen, :defaults_for, :kr_legacy_defaults,
                                  :singleton => true) do |hook, opts, *rest|
          out = hook.call(opts, *rest)
          Array(opts).each do |o|
            next unless o.respond_to?(:krl_default) && !o.krl_default.nil?
            out[o] = o.krl_default
          end
          out
        end
      end

      def default_for(d, min)
        case d[:type]
        when :toggle then truthy?(d[:default]) ? 1 : 0
        when :enum then d[:default].to_i
        when :number, :slider then d[:default].to_i - min
        end
      end

      def truthy?(value)
        value == true || (value.is_a?(Numeric) && value.to_i != 0) ||
          ["true", "on", "yes", "enabled", "1"].include?(value.to_s.downcase)
      end

      # The buttons that lived on the old settings pages
      def register_buttons
        s = KantoReloaded::Settings
        s.register(:wild_link_reset_search_levels, :type => :button, :owner => :wild_link,
          :name => "Reset Search Levels",
          :description => "Erase all permanent Wild Link Search Level progression (up to 999 per Pokemon; up to 8 extra shiny rolls; chains end when the Pokemon, method or map changes).",
          :on_press => proc { KantoReloaded::KIFSettings.send(:reset_search_levels) })
        s.register(:weather_open_forecast, :type => :button, :owner => :weather_system,
          :name => "Open Forecast",
          :description => "View current and next-cycle weather across the world map.",
          :on_press => proc { pbFadeOutIn { KantoReloaded::WeatherSystem::Forecast.open } })
        s.register(:trainer_control_claim_pending, :type => :button, :owner => :trainer_control,
          :name => "Claim Pending Transfers",
          :description => "Move pending Pink Slips Pokemon and held items into available storage.",
          :on_press => proc { KantoReloaded::TrainerControl::PinkSlips.deliver_pending(true) })
        s.register(:trainer_control_view_records, :type => :button, :owner => :trainer_control,
          :name => "View Trainer Records",
          :description => "Search, sort, filter, inspect, and reset individual trainer records.",
          :on_press => proc { KantoReloaded::TrainerControl::BattleRecordsUI.open })
        s.register(:trainer_control_reset_records, :type => :button, :owner => :trainer_control,
          :name => "Reset All Trainer Records",
          :description => "Permanently erase every battle record and trainer memory in this save.",
          :on_press => proc { KantoReloaded::KIFSettings.send(:reset_all_records) })
      end

      def reset_search_levels
        w = KantoReloaded::WildLink
        return unless KantoReloaded::PopupWindow.confirm(
          _INTL("Erase every Wild Link Search Level? This cannot be undone."),
          :default => false, :serious => true, :theme => :warning
        )
        if w::Runtime.active?
          w::Runtime.clear_target(:reset, true)
        elsif w::Runtime.chain_active?
          w.break_chain
        end
        w.reset_search_levels
        w.toast(:success, _INTL("Wild Link Search Levels reset."))
      end

      def reset_all_records
        tc = KantoReloaded::TrainerControl
        records = tc::BattleRecords.all_records
        memories = tc::TrainerMemory.all
        if records.empty? && memories.empty?
          KantoReloaded::Toast.warning(_INTL("There are no trainer records to reset."))
          return
        end
        return unless KantoReloaded::PopupWindow.confirm(
          _INTL("Reset all trainer records and adaptation memory in this save?"), :default => false
        )
        count = tc::BattleRecords.clear
        memory_count = tc::TrainerMemory.clear
        KantoReloaded::Toast.success(_INTL("Reset {1} records and {2} memories.", count, memory_count))
      end
    end
  end
end

KantoReloaded::KIFSettings.boot
