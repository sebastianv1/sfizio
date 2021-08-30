require 'sfizio/brew_cli/tap_info'

module Sfizio
    class Clean
        attr_reader :tap_path
        def initialize(tap_path)
            @tap_path = tap_path
        end

        def clean!
            puts "TODO"
        end
    end
end