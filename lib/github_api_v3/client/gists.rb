module GitHub
  class Client

    # Contains methods for the Gists API.
    #
    # @see http://developer.github.com/v3/gists/
    module Gists
      
      # List gists.
      #
      # Gets a list of all gists for a specified user. If called
      # without username, returns gists for the authenticated user.
      # If unauthenticated, returns all public gists.
      #
      # @param username [String] Username to get gists for.
      # @return [Array] Array containing each gist.
      # @see http://developer.github.com/v3/gists/#list-gists
      # @example
      #   GitHub.gists('caseyscarborough')
      # @example
      #   GitHub.gists
      def gists(username=nil)
        if username
          get "/users/#{username}/gists"
        else
          get "/gists"
        end
      end

      # Get a single gist.
      #
      # @param id [Integer] The ID of the gist to retrieve.
      # @return [Hash] Information about the gist.
      # @see http://developer.github.com/v3/gists/#get-a-single-gist
      # @example
      #   GitHub.gist(5928712)
      def gist(id)
        get "/gists/#{id}"
      end

      # Create a gist.
      #
      # Requires authentication
      #
      # @param files [Hash] The files to add to the gist.
      # @param options [Hash] Optional options when creating the gist.
      # @option options [Boolean] :public Whether the gist should be public. True by default.
      # @option options [String] :description Gist description.
      # @return [Hash] Gist information.
      # @see http://developer.github.com/v3/gists/#create-a-gist
      # @example
      #   client.create_gist(files: {"file1.txt" => { content: "File contents" }}, description: "Gist description", public: "false")
      def create_gist(files={}, options={:public => true})
        options.merge!(files)
        post "/gists", auth_params, options
      end

      # Check if a gist is starred.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if it is starred, false if not.
      # @see http://developer.github.com/v3/gists/#check-if-a-gist-is-starred
      def gist_starred?(id)
        boolean_get "/gists/#{id}/star", auth_params
      end

      # Star a gist.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/gists/#star-a-gist
      # @example
      #   client.star_gist(5928712)
      def star_gist(id)
        boolean_put "/gists/#{id}/star", auth_params
      end

      # Unstar a gist.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/gists/#unstar-a-gist
      # @example
      #   client.unstar_gist(5928712)
      def unstar_gist(id)
        boolean_delete "/gists/#{id}/star", auth_params
      end

      # Fork a gist.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/gists/#fork-a-gist
      # @example
      #   client.fork_gist(5928712)
      def fork_gist(id)
        boolean_post "/gists/#{id}/fork", auth_params, {}
      end

      # Delete a gist.
      #
      # Requires authentication.
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/gists/#delete-a-gist
      # @example
      #   client.delete_gist(5928712)
      def delete_gist(id)
        boolean_delete "/gists/#{id}", auth_params
      end
    end

  end
end