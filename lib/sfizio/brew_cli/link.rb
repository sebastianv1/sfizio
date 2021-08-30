require 'open3'

module Sfizio
    module Brew
        class Link
            def self.link(formula, overwrite = false)
                command = "brew link #{formula} -v"
                command << "  --overwrite" if overwrite
                stdout, stderr, status = Open3.capture3(command)
                raise "#{stderr}" if status.exitstatus == 1
                puts stdout
            end

            def self.unlink(formula)
                stdout, stderr, status = Open3.capture3("brew unlink #{formula}")
                raise "#{stderr}" if status.exitstatus == 1
            end
        end
    end
end