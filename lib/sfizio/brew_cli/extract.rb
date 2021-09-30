require 'open3'

module Sfizio
    module Brew
        class Extract
            def self.formula(formula, version, tap_path, logger)
                command = ["brew extract"]
                command << "--version=#{version}" if version
                command << "#{formula}"
                command << "#{tap_path}"
                puts command.join(' ')
                stdout, stderr, status = Open3.capture3(command.join(' '))
                raise stderr unless status.exitstatus == 0
            end
        end
    end
end