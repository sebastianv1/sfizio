
require 'sfizio/brewfile/brewfile'

module Sfizio
    class Brewfile
        def brew(name, version)
            formula = Sfizio::Formula.new(name, version)
            @formulas << formula
        end
    end
end