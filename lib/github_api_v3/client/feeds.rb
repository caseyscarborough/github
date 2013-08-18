module GitHub
  class Client

    # Methods for the Feeds API, which looks pretty much useless.
    #
    # http://developer.github.com/v3/activity/feeds/
    module Feeds

      # List feeds.
      #
      # Requires authentication
      # @return [Hash] Feed information.
      # @see http://developer.github.com/v3/activity/feeds/#list-feeds
      def feeds
        get "/feeds", auth_params
      end

    end

  end
end