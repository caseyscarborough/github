module GitHub
  class Client

    # Contains methods for the Events API.
    #
    # @see http://developer.github.com/v3/activity/events/
    module Events

      # List public events.
      #
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-public-events
      # @example
      #   GitHub.events
      def events
        get '/events'
      end
      alias :public_events :events

      # List repository events.
      #
      # @param owner [String] Owner username.
      # @param repo [String] The repository name.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-repository-events
      # @example
      #   GitHub.repo_events('caseyscarborough','github')
      def repo_events(owner, repo)
        get "/repos/#{owner}/#{repo}/events"
      end

      # List issue events for a repository.
      #
      # @param owner [String] Owner username.
      # @param repo [String] The repository name.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-issue-events-for-a-repository
      def repo_issue_events(owner, repo)
        get "/repos/#{owner}/#{repo}/issues/events"
      end

      # List public events for a network of repositories.
      #
      # @param owner [String] Owner username.
      # @param repo [String] The repository name.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-public-events-for-a-network-of-repositories
      def repo_network_events(owner, repo)
        get "/networks/#{owner}/#{repo}/events"
      end

      # List public events for an organization.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-public-events-for-an-organization
      def organization_events(org)
        get "/orgs/#{org}/events"
      end

      # List events that a user has received.
      #
      # @param username [String] Username for user to get events for.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-events-that-a-user-has-received
      def received_events(username)
        get "/users/#{username}/received_events"
      end

      # List public events that a user has received.
      #
      # @param username [String] Username for user to get events for.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-public-events-that-a-user-has-received
      def public_received_events(username)
        get "/users/#{username}/received_events/public"
      end

      # List events performed by a user.
      #
      # @param username [String] Username for user to get events for.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-events-performed-by-a-user
      def user_events(username)
        get "/users/#{username}/events"
      end

      # List public events performed by a user.
      #
      # @param username [String] Username for user to get events for.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-public-events-performed-by-a-user
      def public_user_events(username)
        get "/users/#{username}/events/public"
      end

      # List events for an organization.
      #
      # Requires authentication. Returns the user's organization events.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of events.
      # @see http://developer.github.com/v3/activity/events/#list-events-for-an-organization
      def user_organization_events(org)
        get "/users/#{login}/events/orgs/#{org}"
      end

    end

  end
end
