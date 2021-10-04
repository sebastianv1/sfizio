require 'sfizio/brew_cli/tap_info'

module Sfizio
    class Clean
        attr_reader :tap_path
        attr_reader :brewfile
        attr_reader :logger
        
        def initialize(tap_path, brewfile, logger)
            @tap_path = tap_path
            @brewfile = brewfile
            @logger = logger
        end

        def clean!
            if brewfile
                brewfile.formulas.each do |f|
                    begin
                        Sfizio::Brew::Uninstall.formula(f.local_tap_path)
                    rescue StandardError => exception
                        logger.debug("Couldn't uninstall #{f.local_tap_path}")
                    end
                end
            end

            begin
                Sfizio::Brew::Tap.untap(tap_path, force: true)
            rescue StandardError => exception
                logger.debug("Couldn't untap local tap path.")
            end
        end
    end
end