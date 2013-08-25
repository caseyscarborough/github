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
        post "/gists", body: options
      end

      # Edit a gist
      #
      # Requires authentication.
      #
      # @param id [Integer] The ID of the Gist to edit.
      # @param files [Hash] Filenames in the gist.
      # @param options [Hash] Optional options when creating the gist.
      # @option options [Boolean] :public Whether the gist should be public. True by default.
      # @option options [String] :description Gist description.
      # @return [Hash] Gist information.
      def edit_gist(id, files={}, options={:public => true})
        options.merge!(files)
        patch "/gists/#{id}", body: options
      end

      # Check if a gist is starred.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @return [Boolean] True if it is starred, false if not.
      # @see http://developer.github.com/v3/gists/#check-if-a-gist-is-starred
      def gist_starred?(id)
        boolean_request :get, "/gists/#{id}/star"
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
        boolean_request :put, "/gists/#{id}/star"
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
        boolean_request :delete, "/gists/#{id}/star"
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
        boolean_request :post, "/gists/#{id}/fork"
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
        boolean_request :delete, "/gists/#{id}"
      end

      # List comments on a gist.
      #
      # @param id [Integer] The Gist ID.
      # @return [Array] An array of comments.
      # @see http://developer.github.com/v3/gists/comments/#list-comments-on-a-gist
      # @example
      #   GitHub.gist_comments(5928712)
      def gist_comments(id)
        get "/gists/#{id}/comments"
      end

      # Get a single comment on a gist.
      #
      # @param id [Integer] The Gist ID.
      # @param comment_id [Integer] The comment ID.
      # @return [Hash] The comment data.
      # @see http://developer.github.com/v3/gists/comments/#get-a-single-comment
      # @example
      #   GitHub.gist_comment(5928712, 889239)
      def gist_comment(id, comment_id)
        get "/gists/#{id}/comments/#{comment_id}"
      end

      # Create a gist comment.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @param comment [String] The comment text.
      # @return [Hash] The Gist information.
      # @see http://developer.github.com/v3/gists/comments/#create-a-comment
      # @example
      #   client.create_gist_comment(5928712, 'Awesome!')
      def create_gist_comment(id, comment)
        post "/gists/#{id}/comments", body: { body: comment }
      end

      # Edit an existing gist comment.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @param comment_id [Integer] The ID of the comment to edit.
      # @param comment [String] The comment text.
      # @return [Hash] The Gist information.
      # @see http://developer.github.com/v3/gists/comments/#edit-a-comment
      # @example
      #   client.edit_gist_comment(5928712, 889239, 'Even more awesome!')
      def edit_gist_comment(id, comment_id, comment)
        patch "/gists/#{id}/comments/#{comment_id}", body: { body: comment }
      end

      # Delete a gist comment.
      #
      # Requires authentication.
      #
      # @param id [Integer] The Gist ID.
      # @param comment_id [Integer] The ID of the comment to delete.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/gists/comments/#delete-a-comment
      # @example
      #   client.delete_gist_comment(5928712, 889239)
      def delete_gist_comment(id, comment_id)
        boolean_request :delete, "/gists/#{id}/comments/#{comment_id}"
      end
      
    end

  end
end