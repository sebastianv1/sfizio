
require 'open3'

module Sfizio
    module Brew
        class Info
            attr_reader :info
            attr_reader :is_valid

            def initialize(info, is_valid)
                @info = info
                @is_valid = is_valid
            end

            def is_valid?
                is_valid
            end

            def is_installed?
                !info["installed"].empty?
            end

            def self.formula(formula, logger)
                logger.debug("Fetching brew info for #{formula}")
                stdout, stderr, status = Open3.capture3("brew info #{formula} --json")
                logger.debug(stderr) if stderr
                is_valid = status.exitstatus == 0
                info = JSON.parse(stdout)[0] unless stdout.empty?
                Info.new(info, is_valid)
            end
        end
    end
end