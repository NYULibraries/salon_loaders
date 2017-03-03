module PermalinksLoaders
  class Permalink
    attr_accessor :key, :url

    def initialize(key, url)
      @key = key
      @url = url
    end

  end
end
