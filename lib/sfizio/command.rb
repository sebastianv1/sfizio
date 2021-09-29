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
                Sfizio::Installer.new(brewfile_path, verbose: argv.include?("-v")).install!
            when "clean"
                puts "TODO"
            when "help"
                puts "sfizio [command] <option>\n\nCommands:\ninstall, clean\n\nOptions:\n-v Verbose output"
            else
                puts "Unknown command. Refer to `sfizio help`"
                exit(1)
            end
        end
        
    end
end
