module SalonLoaders
  module Sources
    module LibguidesWrapper
      class AzAsset
        extend Forwardable

        delegate [:id, :url, :library_review] => :libguides_asset

        attr_accessor :libguides_asset

        def initialize(libguides_asset)
          @libguides_asset = libguides_asset
        end

        def enable_proxy?
          library_review_match_data[:proxy_flag] === "PROXY_YES" if library_review_match_data && library_review_match_data[:proxy_flag]
        end

        def resource_url
          library_review_match_data[:url] if library_review_match_data
        end

        def metalib_id
          library_review_match_data[:id] if library_review_match_data
        end

        def salon_id
          url_match_data[:salon_id] if url_match_data
        end

        private
        NULL_ID_TEXT = "NULL"
        SALON_URL_PREFIX = "https://persistent.library.nyu.edu/arch/"
        # Expected to find library_review in the format
        # => "ONLY KARMS | NYU{METALIB_ID} | PROXY_(YES|NO) | http://url.com"
        LIBRARY_REVIEW_REGEX = /[\w\s]+\|\s*((?<id>NYU\d+)|#{NULL_ID_TEXT})\s*\|\s*(?<proxy_flag>PROXY_(YES|NO))\s*\|\s*(?<url>#{URI.regexp})/
        SALON_ID_REGEX = /^#{SALON_URL_PREFIX}(?<salon_id>([\w\d]+))/

        def library_review_match_data
          @library_review_match_data ||= library_review.match(LIBRARY_REVIEW_REGEX) if library_review
        end

        def url_match_data
          @url_match_data ||= url.match(SALON_ID_REGEX) if url
        end
      end
    end
  end
end
