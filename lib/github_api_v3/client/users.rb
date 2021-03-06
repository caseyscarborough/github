 module GitHub
  class Client

    # Contains methods for the Users API.
    #
    # @see http://developer.github.com/v3/users/
    module Users
      
      # Returns a single user.
      #
      # If called without the username parameter, it will return the
      # currently authenticated user.
      #
      # @param username [String] A GitHub username.
      # @return [Hash]
      # @see http://developer.github.com/v3/users/#get-a-single-user
      # @see http://developer.github.com/v3/users/#get-the-authenticated-user
      # @example
      #   GitHub.user('caseyscarborough')
      def user(username=nil)
        if username
          get "/users/#{username}"
        else
          get '/user'
        end
      end

      # Returns a list of all GitHub users.
      #
      # @return [Array]
      # @see http://developer.github.com/v3/users/#get-all-users
      def users
        get '/users'
      end

      # Get all emails for an authenticated user.
      #
      # @return [Array]
      # @see http://developer.github.com/v3/users/emails/#list-email-addresses-for-a-user
      # @example
      #   client = GitHub::Client.new(login: 'username', access_token: 'abcdefghijklmnopqrstuvwxyz12345')
      #   client.emails # => ["email@example.com", "email2@example.com"]
      def emails
        get '/user/emails'
      end

      # Follow a user.
      #
      # Requires authentication.
      #
      # @param username [String] Username of the user to follow.
      # @return [Boolean] True on success.
      # @see http://developer.github.com/v3/users/followers/#follow-a-user
      # @example
      #   client.follow('caseyscarborough')
      def follow(username)
        boolean_request :put, "/user/following/#{username}"
      end

      # Checks to see if a user is following another user.
      #
      # @param username [String] The user following.
      # @param target_username [String] The target user.
      # @return [Boolean] True if user does follow target user.
      # @see http://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
      # @example
      #   GitHub.follows?('caseyscarborough', 'matz')
      def follows?(username, target_username)
        boolean_request :get, "/users/#{username}/following/#{target_username}"
      end

      # List a user's followers.
      #
      # If username is left blank, returns the currently authenticated user's
      # list of followers.
      #
      # @param username [String] The username to get a list of followers for.
      # @return [Array] Array of hashes of each user.
      # @see http://developer.github.com/v3/users/followers/#list-followers-of-a-user
      # @example
      #   GitHub.followers('caseyscarborough')
      # @example
      #   # Get authenticated user's followers
      #   client.followers
      def followers(username=nil)
        if username
          get "/users/#{username}/followers"
        else
          get '/user/followers'
        end
      end

      # List users who a specific user is following.
      #
      # @param username [String] The username of the user to get the list of users they arefollowing.
      # @return [Array] Array of hashes of each user.
      # @see http://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
      # @example
      #   GitHub.following('caseyscarborough')
      def following(username)
        get "/users/#{username}/following"
      end

      # Check if an authenticated user is following another user.
      #
      # Requires the user to be authenticated.
      #
      # @param username [String] The username of the user to check against.
      # @return [Boolean] True if user does follow the target user, false if not.
      # @example
      #   client.following?('caseyscarborough')
      def following?(username)
        boolean_request :get, "/user/following/#{username}"
      end

      # Unfollow a user.
      #
      # Requires authentication.
      #
      # @param username [String] The username of the user to unfollow.
      # @return [Boolean] True if successful, false otherwise.
      # @example
      #   client.unfollow('matz')
      def unfollow(username)
        boolean_request :delete, "/user/following/#{username}"
      end

      # Get a list of public keys for a user.
      #
      # If username left blank, get currently authenticated user's keys.
      #
      # @param username [String] The username to get public keys for.
      # @return [Array] Array of hashes of public keys.
      # @example
      #   GitHub.keys('username')
      # @example
      #   client.keys
      def keys(username=nil)
        if username
          get "/users/#{username}/keys"
        else
          get '/user/keys'
        end
      end

      # Get a public key.
      #
      # Requires authentication.
      #
      # @param id [Integer] The id of the key to retrieve.
      # @return [Hash]
      # @example
      #   client.key(123)
      def key(id)
        get "/user/keys/#{id}"
      end

      # Create a public key.
      #
      # Requires authentication.
      #
      # @param title [String] The title of the public key.
      # @param key [String] The actual public key.
      # @return [Hash] The public key's data.
      # @see http://developer.github.com/v3/users/keys/#create-a-public-key
      # @example
      #   client.create_key('octocat@octomac', 'ssh-rsa AAA...')
      def create_key(title, key)
        post '/user/keys', :body => {:title => title, :key => key}
      end

      # Update a public key
      #
      # Requires authentication.
      #
      # @param id [Integer] The ID of the public key to update.
      # @param title [String] The title of the public key.
      # @param key [String] The actual public key.
      # @return [Hash] The public key's data. 
      # @see http://developer.github.com/v3/users/keys/#update-a-public-key
      # @example
      #   client.update_key(1, 'octocat@octomac', 'ssh-rsa AAA...')
      def update_key(id, title, key)
        patch "/user/keys/#{id}", :body => {:title => title, :key => key}
      end

      # Remove a public key from a user's account.
      #
      # Requires authentication.
      #
      # @param id [Integer] The id of the integer to delete.
      # @return [Boolean] True if success, false if not.
      # @example
      #   client.delete_key(123)
      def delete_key(id)
        boolean_request :delete, "/user/keys/#{id}"
      end

      # List notifications.
      #
      # Requires authentication.
      #
      # @param options [Hash] Optional parameters.
      # @option options [Boolean] :all Show notifications marked as read.
      # @option options [Boolean] :participating Show only notifications that the user is participating in or mentioned in.
      # @option options [String] :time Only show notifications since a given time. Should be in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ), such as: “2012-10-09T23:39:01Z”.
      # @return [Array] List of notifications.
      # @see http://developer.github.com/v3/activity/notifications/#list-your-notifications
      # @example
      #   client.notifications
      def notifications(options={})
        get "/notifications", :params => options
      end

      # List notifications for a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param options [Hash] Optional parameters.
      # @option options [Boolean] :all Show notifications marked as read.
      # @option options [Boolean] :participating Show only notifications that the user is participating in or mentioned in.
      # @option options [String] :time Only show notifications since a given time. Should be in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ), such as: “2012-10-09T23:39:01Z”.
      # @return [Array] List of notifications.
      # @see http://developer.github.com/v3/activity/notifications/#list-your-notifications-in-a-repository
      # @example
      #   client.repo_notifications('caseyscarborough','github')
      def repo_notifications(owner, repo, options={})
        get "/repos/#{owner}/#{repo}/notifications"
      end

      # List repositories a user is starring.
      #
      # Can be used unauthenticated or authenticated.
      #
      # @param username [String] The target user's username.
      # @return [Array]
      # @see http://developer.github.com/v3/activity/starring/#list-repositories-being-starred
      # @example
      #   GitHub.starring('caseyscarborough')
      # @example
      #   client.starring
      def starring(username=nil)
        if username
          get "/users/#{username}/starred"
        else
          get "/user/starred"
        end
      end

      # Check if you are starring a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/activity/starring/#check-if-you-are-starring-a-repository
      # @example
      #   client.starring?('caseyscarborough','github')
      def starring?(owner, repo)
        boolean_request :get, "/user/starred/#{owner}/#{repo}"
      end

      # List repositories a user is watching.
      #
      # @param username [String] The target user's usernmae.
      # @return [Array]
      # @see http://developer.github.com/v3/activity/watching/#list-repositories-being-watched
      # @example
      #   GitHub.watching('caseyscarborough')
      # @example
      #   client.watching
      def watching(username=nil)
        if username
          get "/users/#{username}/subscriptions"
        else
          get "/user/subscriptions"
        end
      end

      # List public organizations for a user.
      #
      # @param username [String] The target user's username.
      # @return [Array] List of organizations.
      # @see http://developer.github.com/v3/orgs/#list-user-organizations
      # @example
      #   GitHub.organizations('caseyscarborough')
      # @example
      #   client.organizations
      def organizations(username=nil)
        if username
          get "/users/#{username}/orgs"
        else
          get "/user/orgs"
        end
      end

      # Get the current client's rate limit info.
      #
      # @return [Hash] The rate limit information.
      # @see http://developer.github.com/v3/rate_limit/
      # @example Unauthenticated client's rate limit.
      #   GitHub.rate_limit
      # @example Authenticated client's rate limit.
      #   client.rate_limit
      def rate_limit
        get "/rate_limit"
      end

    end
  
  end
end