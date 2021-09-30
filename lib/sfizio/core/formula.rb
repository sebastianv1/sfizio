require 'pathname'

module Sfizio
    class Formula
        attr_reader :name
        attr_reader :version
        attr_reader :tap

        def initialize(name, version, tap)
            @name = name
            @version = version
            @tap = tap
        end

        def to_s
            "#{name} -- #{version} from: #{tap}"
        end

        def inspect
            to_s
        end

        def versioned_name
            if version
                "#{name}@#{version}"
            else
                "#{name}"
            end
        end

        def source_path
            if tap
                return "#{tap}/#{name}"
            else
                return name
            end
        end

        def local_tap_path
            "#{Sfizio::TAP_PATH}/#{versioned_name}"
        end

        def fuzzy_linked_kegs
            Dir.glob("#{HOMEBREW_LINKED_KEGS}/*").select { |p| p.match("#{name}@?") }.map { |p| Pathname.new(p).basename.to_s }
        end

        def ==(other)
            name == other.name && version == other.version && tap == other.tap
        end
    end
end