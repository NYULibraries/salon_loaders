module SalonLoaders
  module Sources
    module LibguidesWrapper
      class AzAsset
        extend Forwardable

        delegate [:id, :url, :internal_note] => :libguides_asset

        attr_accessor :libguides_asset

        def initialize(libguides_asset)
          @libguides_asset = libguides_asset
        end

        def enable_proxy?
          #internal_note_match_data[:proxy_flag] === "PROXY_YES" if internal_note_match_data && internal_note_match_data[:proxy_flag]
          internal_note_match_data[:proxy_bool] === "True" if internal_note_match_data && internal_note_match_data[:proxy_bool]
        end

        def resource_url
          internal_note_match_data[:url] if internal_note_match_data
        end

        def metalib_id
          #internal_note_match_data[:id] if internal_note_match_data
          nil
        end

        def salon_id
          url_match_data[:salon_id] if url_match_data
        end

        private
        NULL_ID_TEXT = "NULL"
        SALON_URL_PREFIX = "https://persistent.library.nyu.edu/arch/"
        # Expected to find internal_note in the format
        # => "ONLY KARMS | NYU{METALIB_ID} | PROXY_(YES|NO) | http://url.com"
        #LIBRARY_REVIEW_REGEX = /[\w\s]+\|\s*((?<id>NYU\d+)|#{NULL_ID_TEXT})\s*\|\s*(?<proxy_flag>PROXY_(YES|NO))\s*\|\s*(?<url>#{URI.regexp})/
        INTERNAL_NOTE_REGEX = /[\w\s]+\|[\w\s\:]+\|[\w\s\:]+\|\s*use_proxy:\s*(?<proxy_bool>(True|False))\s*\|\s*url:\s*(?<url>#{URI.regexp})/
        SALON_ID_REGEX = /^#{SALON_URL_PREFIX}(?<salon_id>([\w\d]+))/

        def internal_note_match_data
          @internal_note_match_data ||= internal_note.match(INTERNAL_NOTE_REGEX) if internal_note
        end

        def url_match_data
          @url_match_data ||= url.match(SALON_ID_REGEX) if url
        end
      end
    end
  end
end
