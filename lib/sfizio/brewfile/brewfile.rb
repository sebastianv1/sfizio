require 'sfizio/core/formula'

module Sfizio
    class Brewfile
        attr_accessor :formulas
        attr_accessor :taps

        def initialize(formulas = [], taps = [])
            @formulas = formulas
            @taps = taps
        end

        def self.from_file(path)
            contents = File.open(path, 'r:utf-8', &:read)
            brewfile = Brewfile.new([])
            brewfile.instance_eval(contents)
            brewfile
        end

        def self.from_string(str)
            brewfile = Brewfile.new([])
            brewfile.instance_eval(str)
            brewfile
        end
    end
end