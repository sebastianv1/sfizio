
module Sfizio
    class Formula
        attr_reader :name
        attr_reader :version

        def initialize(name, version)
            @name = name
            @version = version
        end

        def to_s
            "#{name} -- #{version}"
        end

        def versioned_name
            "#{name}@#{version}"
        end

        def ==(other)
            name == other.name && version == other.version
        end
    end
end