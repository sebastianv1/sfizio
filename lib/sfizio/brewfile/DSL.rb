
require 'sfizio/brewfile/brewfile'

module Sfizio
    class Brewfile
        def formula(name, version)
            formula = Sfizio::Formula.new(name, version)
            @formulas << formula
        end
    end
end