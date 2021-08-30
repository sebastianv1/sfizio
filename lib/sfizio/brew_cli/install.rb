require 'open3'

module Sfizio
    module Brew
        class Install
            def self.formula(formula)
                stdout, stderr, status = Open3.capture3("brew install #{formula}")
                is_successful = status.exitstatus == 0
                raise "#{stderr}" unless is_successful
            end
        end
    end
end
