require 'open3'

module Sfizio
  module Brew
    class Tap
      def self.tap(name, url)
        command = ["brew", "tap", name]
        command << url if url
        stdout, stderr, status = Open3.capture3(command.join(' '))
        raise "#{stderr}" if status.exitstatus == 1
      end

      def self.untap(name, force: false)
        command = ["brew", "untap", name]
        command << "-f" if force
        stdout, stderr, status = Open3.capture3(command.join(' '))
        raise "#{stderr}" if status.exitstatus == 1
      end
    end
  end
end