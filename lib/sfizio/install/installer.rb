
require 'sfizio/brewfile/brewfile'
require 'sfizio/brew_cli/tap_info'
require 'sfizio/brew_cli/tap_new'
require 'sfizio/brew_cli/info'
require 'sfizio/brew_cli/link'
require 'sfizio/brew_cli/install'
require 'sfizio/brew_cli/extract'

module Sfizio
    TAP_PATH = "$USER/local-tap"

    class Installer
        attr_reader :brewfile_path

        def initialize(brewfile_path)
            @brewfile_path = brewfile_path
        end

        def install!
            brewfile = Sfizio::Brewfile.from_file(brewfile_path)
            
            local_tap = Sfizio::Brew::TapInfo.tap_path(TAP_PATH)
            unless local_tap.is_valid?
                puts "Creating new local tap."
                Sfizio::Brew::TapNew.tap_new!(TAP_PATH)
                local_tap = Sfizio::Brew::TapInfo.tap_path(TAP_PATH)
            end

            local_tap_info = local_tap.info

            brewfile.formulas.each do |f|
                # Cleanup non-versioned existings formulas
                puts "Looking for existing #{f.name} formula."
                nonversion_info = Sfizio::Brew::Info.formula(f.name)
                if nonversion_info.is_valid? && nonversion_info.is_installed?
                    puts "Unlinking #{f.name}"
                    Sfizio::Brew::Link.unlink(f.name)
                end
                
                # Find all versioned taps already installed into local.
                # Unlink any that are already installed.
                puts "Looking for installed formulas in local tap"
                tap_formulas = local_tap.formulas_with_name(f.name)
                tap_formulas_info = tap_formulas.map { |f| [Sfizio::Brew::Info.formula(f.versioned_name), f] }
                tap_formulas_info.select { |args| args[0].is_installed? }.each do |args|
                    puts "Unlinking #{args[1]}"
                    Sfizio::Brew::Link.unlink(args[1].versioned_name)
                end

                found_info, found_formula = tap_formulas_info.find { |args| args[1] == f }
                
                # Extract into our local tap if not found.
                if !found_info
                    puts "Extracting #{f} into local tap."
                    Sfizio::Brew::Extract.formula(f.name, f.version, TAP_PATH)
                    puts "Installing #{f.versioned_name}"
                    Sfizio::Brew::Install.formula(f.versioned_name)
                elsif !found_info.is_installed?
                    puts "Installing #{found_formula}"
                    Sfizio::Brew::Install.formula(found_formula.versioned_name)
                end
                puts "Linking #{f.versioned_name}"
                Sfizio::Brew::Link.link(f.versioned_name, true)
            end
            
        end
    end
end