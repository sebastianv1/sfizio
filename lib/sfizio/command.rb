require 'sfizio/install/installer'

module Sfizio
    class Command
        attr_reader :argv

        def initialize(argv)
            @argv = argv
        end

        def run!
            logger = Logger.new(STDOUT)
            logger.level = Logger::DEBUG if argv.include?("-v")
            logger.level = Logger::INFO
            logger.formatter = proc do |severity, datetime, progname, msg|
                "#{msg}\n"
            end

            command = argv.first unless argv.empty?
            case command
            when "install"
                brewfile_path = File.join(Dir.pwd, 'Brewfile').to_s
                raise "Unable to find `Brewfile` in directory." unless File.exist?(brewfile_path)
                logger.debug("Loading Brewfile from #{brewfile_path}")
                brewfile = Sfizio::Brewfile.from_file(brewfile_path)
                update = argv.include?("--update")
                Sfizio::Installer.new(brewfile, logger).install!
            when "clean"
                puts "TODO"
            when "help"
                puts "sfizio [command] <option>\n\nCommands:\ninstall, clean\n\nOptions:\n-v Verbose output\n--update Updates formulas. Only supports the install command."
            else
                puts "Unknown command. Refer to `sfizio help`"
                exit(1)
            end
        end
        
    end
end
