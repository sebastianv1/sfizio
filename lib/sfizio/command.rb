require 'sfizio/install/installer'

module Sfizio
    class Command
        attr_reader :argv

        def initialize(argv)
            @argv = argv
        end

        def run!
            command = argv.first unless argv.empty?
            case command
            when "install"
                brewfile_path = File.join(Dir.pwd, 'Brewfile').to_s
                Sfizio::Installer.new(brewfile_path).install!
            when "clean"
                puts "TODO"
            else
                puts "Unknown command. Refer to help."
                exit(1)
            end
        end
        
    end
end
