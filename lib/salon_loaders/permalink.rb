module SalonLoaders
  class Permalink
    attr_accessor :key, :url, :use_proxy

    def initialize(key:, url:, use_proxy: false)
      @key = key
      @url = url.gsub(/ /,'%20')
      @use_proxy = use_proxy
    end

    def url
      return @url unless use_proxy
      "https://ezproxy.library.nyu.edu/login?url=#{URI.encode(@url)}"
    end

  end
end
