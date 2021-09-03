require 'open3'

module Sfizio
    module Brew
        class Install
            def self.formula(formula, logger)
                stdout, stderr, status = Open3.capture3("brew install #{formula}")
                logger.debug(stderr) if stderr
                logger.debug(stdout) if stdout
                is_successful = status.exitstatus == 0
                raise "#{stderr}" unless is_successful
            end
        end
    end
end
