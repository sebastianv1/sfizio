require 'sfizio/core/formula'

module Sfizio
    class Brewfile
        attr_accessor :formulas

        def initialize(formulas = [])
            @formulas = formulas
        end

        def self.from_file(path)
            contents = File.open(path, 'r:utf-8', &:read)
            brewfile = Brewfile.new([])
            brewfile.instance_eval(contents)
            brewfile
        end
    end
end