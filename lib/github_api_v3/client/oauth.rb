module GitHub
  class Client

    # Methods for the Authorizations API.
    #
    # These methods require the user to use basic authentication.
    #
    # @see http://developer.github.com/v3/oauth/#oauth-authorizations-api
    module OAuth

      # List your authorizations.
      #
      # Requires basic authentication.
      #
      # @return [Array] List of authorizations.
      # @see http://developer.github.com/v3/oauth/#list-your-authorizations
      # @example
      #   client = GitHub.client(:login => 'username', :password => 'password')
      #   client.authorizations
      def authorizations
        get "/authorizations"
      end

      # Get a single authorization.
      #
      # Requires basic authentication.
      #
      # @param id [Integer] The ID of the authorization to retrieve.
      # @return [Hash] The authorization information.
      # @see http://developer.github.com/v3/oauth/#get-a-single-authorization
      # @example
      #   client = GitHub.client(:login => 'username', :password => 'password')
      #   client.authorization(12345)
      def authorization(id)
        get "/authorizations/#{id}"
      end

      # Create a new authorization.
      #
      # Requires basic authentication.
      #
      # @param options [Hash] Optional parameters.
      # @option options [Array] :scopes A list of scopes to create the authorization using.
      # @option options [String] :note Note to remind what the OAuth token is for.
      # @option options [String] :note_url URL to remind you what the OAuth token is for.
      # @option options [String] :client_id The 20 character OAuth app client key for which to create the token.
      # @option options [String] :client_secret The 40 character OAuth app client secret for which to create the token.
      # @return [Hash] The new OAuth token information.
      # @see http://developer.github.com/v3/oauth/#create-a-new-authorization
      # @example
      #   client = GitHub.client(:login => 'username', :password => 'password')
      #   client.create_authorization(
      #     :note => 'New authorization',
      #     :client_id => 'ab0487b031b18f9286a6',
      #     :client_secret => '9d667c2b7fae7a329f32b6df17926154'
      #   )
      def create_authorization(options={})
        post "/authorizations", :body => options
      end

      # Update an existing authorization.
      #
      # Requires basic authentication.
      # 
      # @param id [Integer] The ID of the authorization to update.
      # @param options [Hash] Optional parameters.
      # @option options [Array] :scopes Replaces the authorization scopes with these.
      # @option options [Array] :add_scopes A list of scopes to add to this authorization.
      # @option options [Array] :remove_scopes A list of scopes to remove from this authorization.
      # @option options [String] :note Note to remind what the OAuth token is for.
      # @option options [String] :note_url URL to remind you what the OAuth token is for.
      # @return [Hash] The updated OAuth token information.      
      # @see http://developer.github.com/v3/oauth/#update-an-existing-authorization
      # @example
      #   client = GitHub.client(:login => 'username', :password => 'password')
      #   client.update_authorization(1324, :note => 'Updated authorization')
      def update_authorization(id, options={})
        patch "/authorizations/#{id}", :body => options
      end

      # Delete an authorization
      #
      # Requires basic authentication.
      #
      # @param id [Integer] The ID of the authorization to delete.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/oauth/#delete-an-authorization
      # @example
      #   client = GitHub.client(:login => 'username', :password => 'password')
      #   client.delete_authorization(1324)
      def delete_authorization(id)
        boolean_request :delete, "/authorizations/#{id}"
      end

      # def check_authorization(client_id, client_secret, access_token)
      #   get "/applications/#{client_id}/tokens/#{access_token}", {}, basic_auth_headers(client_id, client_secret)
      # end
    end

  end
end