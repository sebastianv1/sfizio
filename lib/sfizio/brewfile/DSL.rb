
require 'sfizio/brewfile/brewfile'

module Sfizio
    class Brewfile
        def formula(name, version, tap: nil)
            formula = Sfizio::Formula.new(name, version, tap)
            @formulas << formula
        end
    end
end