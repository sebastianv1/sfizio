
require 'sfizio/brewfile/brewfile'

module Sfizio
    class Brewfile
        def formula(name, version = nil, tap: nil)
            formula = Sfizio::Formula.new(name, version, tap)
            @formulas << formula
        end

        def tap(name, url: nil)
            tap = Sfizio::Tap.new(name, url)
            @taps << tap
        end
    end
end