#==============================================================================
# Kanto Reloaded Public API Contracts
#==============================================================================

module KantoReloaded
  module API
    CONTRACTS = {
      :log             => { :classification => :stable, :constant => "KantoReloaded::Log" },
      :platform        => { :classification => :stable, :constant => "KantoReloaded::Platform" },
      :hooks           => { :classification => :stable, :constant => "KantoReloaded::Hooks" },
      :events          => { :classification => :stable, :constant => "KantoReloaded::Events" },
      :save_data       => { :classification => :stable, :constant => "KantoReloaded::SaveData" },
      :save_migrations => { :classification => :stable, :constant => "KantoReloaded::SaveMigrations" },
      :save_protection => { :classification => :stable, :constant => "KantoReloaded::SaveProtection" },
      :settings        => { :classification => :stable, :constant => "KantoReloaded::Settings" },
      :messaging       => { :classification => :stable, :constant => "KantoReloaded" },
      :shared_ui       => { :classification => :stable, :constant => "KantoReloaded::UI" },
      :popup_window    => { :classification => :stable, :constant => "KantoReloaded::PopupWindow" },
      :number_picker   => { :classification => :stable, :constant => "KantoReloaded::NumberPicker" },
      :list_state      => { :classification => :stable, :constant => "KantoReloaded::ListState" },
      :item_picker     => { :classification => :stable, :constant => "KantoReloaded::ItemPicker" },
      :toast           => { :classification => :stable, :constant => "KantoReloaded::Toast" },
      :hint_text       => { :classification => :stable, :constant => "KantoReloaded::HintText" },
      :options_ui      => { :classification => :stable, :constant => "KantoReloaded::Options" },
      :settings_ui     => { :classification => :stable, :constant => "KantoReloaded::SettingsUI" },
      :overworld_menu  => { :classification => :stable, :constant => "KantoReloaded::OverworldMenu" },
      :tm_vault        => { :classification => :stable, :constant => "KantoReloaded::TMVault" },
      :reloaded_shop   => { :classification => :stable, :constant => "KantoReloaded::ReloadedShop" },
      :economy_system  => { :classification => :stable, :constant => "KantoReloaded::EconomySystem" },
      :pc_organization => { :classification => :stable, :constant => "KantoReloaded::PCOrganization" },
      :level_locking   => { :classification => :stable, :constant => "KantoReloaded::LevelLocking" },
      :double_abilities => { :classification => :stable, :constant => "KantoReloaded::DoubleAbilities" },
    }.freeze

    def self.contract(name)
      entry = CONTRACTS[name.to_sym]
      entry ? entry.merge(:name => name.to_sym) : nil
    rescue
      nil
    end

    def self.contracts
      result = {}
      CONTRACTS.each { |name, entry| result[name] = entry.merge(:name => name) }
      result
    end
  end
end
