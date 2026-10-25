#==============================================================================
# Kanto Reloaded Bootstrap
#==============================================================================

module KantoReloaded
  ROOT = File.expand_path(File.dirname(__FILE__)) unless const_defined?(:ROOT, false)
  VERSION_FALLBACK = "0.0.0" unless const_defined?(:VERSION_FALLBACK, false)

  class << self
    # The game Legacy runs on, as the log names it ("KIF 1.0.7")
    def game_label
      version = defined?(::KIF::PORT_VERSION) ? ::KIF::PORT_VERSION.to_s : ""
      version.empty? ? "KIF" : "KIF #{version}"
    rescue
      "KIF"
    end

    def version
      path = File.join(KantoReloaded::ROOT, "mod.json")
      return VERSION_FALLBACK unless File.file?(path)
      raw = File.binread(path)
      manifest = if defined?(KantoReloaded::SafeJSON)
                   KantoReloaded::SafeJSON.parse(raw)
                 elsif raw =~ /"version"\s*:\s*"([^"]+)"/
                   { "version" => $1 }
                 end
      value = manifest.is_a?(Hash) ? manifest["version"].to_s.strip : ""
      value.empty? ? VERSION_FALLBACK : value
    rescue
      VERSION_FALLBACK
    end
  end

  module Bootstrap
    class << self
      def boot
        return true if @booted
        load File.join(KantoReloaded::ROOT, "LoadOrder.rb")
        KantoReloaded::LoadOrder.files.each { |relative| load_file(relative) }
        @booted = true
        KantoReloaded::Log.info("Kanto Reloaded Legacy #{KantoReloaded.version} loaded on #{KantoReloaded.game_label}", :bootstrap) if defined?(KantoReloaded::Log)
        true
      rescue StandardError => e
        if defined?(KantoReloaded::Log)
          KantoReloaded::Log.exception("Kanto Reloaded bootstrap failed", e, channel: :bootstrap)
        else
          echoln("[KantoReloaded] Bootstrap failed: #{e.class}: #{e.message}") rescue nil
        end
        raise
      end

      private

      def load_file(relative)
        path = File.expand_path(File.join(KantoReloaded::ROOT, relative))
        raise "Load path escapes Kanto Reloaded: #{relative}" unless path.start_with?(KantoReloaded::ROOT)
        raise "Missing Kanto Reloaded file: #{relative}" unless File.file?(path)
        load path
      end
    end
  end
end

KantoReloaded::Bootstrap.boot
