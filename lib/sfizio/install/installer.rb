require 'logger'
require 'sfizio/brewfile/brewfile'
require 'sfizio/brew_cli/tap_info'
require 'sfizio/brew_cli/tap_new'
require 'sfizio/brew_cli/info'
require 'sfizio/brew_cli/link'
require 'sfizio/brew_cli/install'
require 'sfizio/brew_cli/extract'

module Sfizio
    TAP_PATH = "sfizio/local-tap"

    class Installer
        attr_reader :brewfile
        attr_reader :logger

        def initialize(brewfile, logger)
            @brewfile = brewfile
            @logger = logger
        end

        def install!
            logger.debug("Evaluating brewfile with formulas:\n#{brewfile.formulas.join("\n")}")
            
            local_tap = Sfizio::Brew::TapInfo.tap_path(TAP_PATH, logger)
            logger.info("Setting up enviornment...")
            unless local_tap.is_valid?
                logger.debug("Local tap at #{TAP_PATH} not found. Configuring tap.")
                Sfizio::Brew::TapNew.tap_new!(TAP_PATH, logger)
            end

            brewfile.formulas.each do |f|
                f.fuzzy_linked_kegs.each do |linked|
                    logger.debug("Unlinking existing formula #{linked}")
                    Sfizio::Brew::Link.unlink(linked, logger)
                end

                logger.info("Installing formula #{f.name} at version #{f.version}")
                formula_info = Sfizio::Brew::Info.formula(f.local_tap_path, logger)
                if formula_info.is_valid?
                    unless formula_info.is_installed?
                        logger.debug("Found local formula #{f.name} that isn't installed.")
                        Sfizio::Brew::Install.formula(f.local_tap_path, logger)
                    else
                        logger.debug("Found installed local formula #{f.name}. Linking.")
                        Sfizio::Brew::Link.link(f.local_tap_path, logger)
                    end
                else
                    logger.debug("Didn't find formula #{f.versioned_name}. Extracting into local tap at #{TAP_PATH}")
                    Sfizio::Brew::Extract.formula(f.source_path, f.version, TAP_PATH, logger)
                    Sfizio::Brew::Install.formula(f.local_tap_path, logger)
                end
            end
            logger.info("Successfully installed all formula!")
        end
    end
end