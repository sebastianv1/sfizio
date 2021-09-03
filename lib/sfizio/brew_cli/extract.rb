require 'open3'

module Sfizio
    module Brew
        class Extract
            def self.formula(formula, version, tap_path, logger)
                stdout, stderr, status = Open3.capture3("brew extract --version=#{version} #{formula} #{tap_path}")
                logger.debug(stderr) if stderr
                logger.debug(stdout) if stdout
                raise stderr unless status.exitstatus == 0
            end
        end
    end
end