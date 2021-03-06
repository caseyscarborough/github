module GitHub
  class Client

    # Methods for the Feeds API, which looks pretty much useless.
    #
    # @see http://developer.github.com/v3/activity/feeds/
    module Feeds

      # List feeds.
      #
      # Requires authentication
      # @return [Hash] Feed information.
      # @see http://developer.github.com/v3/activity/feeds/#list-feeds
      def feeds
        get "/feeds"
      end

    end

  end
end