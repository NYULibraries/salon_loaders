module PermalinksLoaders
  module Sources
    module LibguidesWrapper
      class AzAsset
        extend Forwardable

        delegate [:id, :meta, :library_review] => :libguides_asset

        attr_accessor :libguides_asset

        def initialize(libguides_asset)
          @libguides_asset = libguides_asset
        end

        def enable_proxy?
          meta["enable_proxy"] == 1 if meta
        end

        def url
          library_review_match_data[:url] if library_review_match_data
        end

        def metalib_id
          library_review_match_data[:id] if library_review_match_data
        end

        private
        LIBRARY_REVIEW_REGEX = /[\w\s]+\|\s+(?<id>NYU\d+)\s+\|\s+(?<url>#{URI.regexp})/

        def library_review_match_data
          @library_review_match_data ||= library_review.match(LIBRARY_REVIEW_REGEX) if library_review
        end
      end
    end
  end
end
