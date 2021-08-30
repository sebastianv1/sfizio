
require 'open3'

module Sfizio
    module Brew
        class TapNew
            def self.tap_new!(tap_path)
                stdout, stderr, status = Open3.capture3("brew tap-new #{tap_path} --no-git")
                raise "#{stderr}" if status.exitstatus == 1
            end
        end
    end
end