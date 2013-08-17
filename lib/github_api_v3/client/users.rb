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
          get '/user', auth_params
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
        get '/user/emails', auth_params
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
        put "/user/following/#{username}", auth_params, true
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
        response = self.class.get "/users/#{username}/following/#{target_username}"
        response.code == 204
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
          get '/user/followers', auth_params
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
        response = self.class.get "/user/following/#{username}", query: auth_params
        response.code == 204
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
        delete "/user/following/#{username}", auth_params, true
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
          get '/user/keys', auth_params
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
        get "/user/keys/#{id}", auth_params
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
        delete "/user/keys/#{id}", auth_params, true
      end
    end
  
  end
end