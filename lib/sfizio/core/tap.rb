module Sfizio
  class Tap
    attr_accessor :name
    attr_accessor :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def ==(other)
      name == other.name && url == other.url
    end
  end
end