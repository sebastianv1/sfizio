require 'open3'

module Sfizio
  module Brew
    class Uninstall
      def self.formula(formula)
        command = ["brew", "uninstall", formula]
        stdout, stderr, status = Open3.capture3(command.join(' '))
        raise stderr unless status.exitstatus == 0
      end
    end
  end
end