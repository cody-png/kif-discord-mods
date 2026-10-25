#==============================================================================
# Kanto Reloaded - Reloaded Shop Defaults
#==============================================================================

module KantoReloaded
  module ReloadedShop
    module Defaults
      CATEGORIES = [
        { "id" => "items",       "name" => "Items" },
        { "id" => "medicine",    "name" => "Medicine" },
        { "id" => "poke_balls",  "name" => "Pokeballs" },
        { "id" => "tms_hms",     "name" => "TM/HMs" },
        { "id" => "berries",     "name" => "Berries" },
        { "id" => "battle_items","name" => "Battle Items" },
        { "id" => "kuray_eggs",  "name" => "K-Eggs" },
        { "id" => "key_items",   "name" => "Key Items" },
        { "id" => "mail",        "name" => "Mail" }
      ].freeze

      # K-Eggs in the order the old list had them (KIF's egg numbers); the
      # Hoenn K-Egg (33) is a test egg KIF no longer sells
      K_EGG_ORDER = ([0, 1, 32, 21, 20] + (2..19).to_a + (22..31).to_a).freeze

      POCKET_CATEGORIES = {
        1 => "items",
        2 => "medicine",
        3 => "poke_balls",
        4 => "tms_hms",
        5 => "berries",
        6 => "mail",
        7 => "battle_items",
        8 => "key_items"
      }.freeze

      module_function

      # Everything KIF's Kuray Shop can sell, by symbol: KIF::KurayShop's own
      # list (TMs by the move they teach), the Rocket Ball, then the K-Eggs.
      # KIF 0.20.7's item numbers (the old list) mean other items in PIF
      # 6.8.2. What's actually in stock still comes from the list KIF builds
      # when the shop opens.
      def kif_items
        list = []
        if defined?(::KIF::KurayShop::ITEMS)
          entries = ::KIF::KurayShop::ITEMS.dup
          entries << ::KIF::KurayShop::ROCKET_BALL if defined?(::KIF::KurayShop::ROCKET_BALL)
          entries.each do |entry, *_prices|
            id = (::KIF::KurayShop.resolve(entry) rescue nil)
            list << id if id && !list.include?(id)
          end
        end
        if defined?(::KIF::KurayEggs) && ::KIF::KurayEggs.respond_to?(:symbol)
          K_EGG_ORDER.each do |number|
            id = (::KIF::KurayEggs.symbol(number) rescue nil)
            list << id if id && (GameData::Item.exists?(id) rescue false) && !list.include?(id)
          end
        end
        list
      end

      def category_for(item)
        data = GameData::Item.try_get(item) rescue nil
        return "items" unless data
        if defined?(::KIF::KurayEggs) && ::KIF::KurayEggs.respond_to?(:egg?)
          return "kuray_eggs" if ::KIF::KurayEggs.egg?(data.id)
        else
          number = data.id_number.to_i rescue 0
          return "kuray_eggs" if number >= 2000 && number <= 2033
        end
        POCKET_CATEGORIES[data.pocket.to_i] || "items"
      end

      def categories
        CATEGORIES.each_with_index.map do |entry, index|
          entry.merge("order" => index)
        end
      end
    end
  end
end
