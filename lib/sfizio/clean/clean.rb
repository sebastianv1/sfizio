require 'sfizio/brew_cli/tap_info'

module Sfizio
    class Clean
        attr_reader :tap_path
        attr_reader :brewfile
        def initialize(tap_path, brewfile)
            @tap_path = tap_path
            @brewfile = brewfile
        end

        def clean!
            if brewfile
                brewfile.formulas.each { |f| Sfizio::Brew::Uninstall.formula(f.local_tap_path) }
            end

            Sfizio::Brew::Tap.untap(tap_path, force: true)
        end
    end
end