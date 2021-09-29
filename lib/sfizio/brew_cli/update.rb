require 'open3'

module Sfizio
  module Brew
      class Update
          def self.run
              stdout, stderr, status = Open3.capture3("brew update")
              raise stderr unless status.exitstatus == 0
          end
      end
  end
end