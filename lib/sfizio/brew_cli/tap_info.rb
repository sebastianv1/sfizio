require 'open3'
require 'json'
require 'sfizio/core/formula'

module Sfizio
    module Brew
        class TapInfo
            attr_reader :info
            attr_reader :is_valid 

            def initialize(info, is_valid)
                @info = info
                @is_valid = is_valid
            end

            def self.tap_path(tap_path, logger)
                stdout, stderr, status = Open3.capture3("brew tap-info #{tap_path} --json")
                raise stderr if status.exitstatus == 1 || stdout.empty?
                info = JSON.parse(stdout)[0]
                is_valid = info['installed'] == true
                TapInfo.new(info, is_valid)
            end

            def is_valid?
                is_valid
            end

            def formulas_with_name(formula)
                found = info['formula_names'].select { |f| f.match("#{formula}@.*") }
                found.map { |f| f.match("(#{formula})@(.*)").captures }.map do |m|
                    Sfizio::Formula.new(m[0], m[1])
                end
            end
        end
    end
end