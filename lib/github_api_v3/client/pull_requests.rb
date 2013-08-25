module GitHub
  class Client

    # Methods for the Pull Requests API.
    #
    # @see http://developer.github.com/v3/pulls/
    module PullRequests
      # List pull requests for a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Array] Array of pull requests.
      # @see http://developer.github.com/v3/pulls/#list-pull-requests
      # @example
      #   GitHub.pull_requests('caseyscarborough','github')
      def pull_requests(owner, repo)
        get "/repos/#{owner}/#{repo}/pulls"
      end

      # Get a single pull request.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Hash] The pull request information.
      # @see http://developer.github.com/v3/pulls/#get-a-single-pull-request
      # @example
      #   GitHub.pull_request('caseyscarborough','github', 1)
      def pull_request(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}"
      end

      # Create a new pull request.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param options [Hash] Options.
      # @option options [String] :title (required) The pull request title.
      # @option options [String] :body
      # @option options [String] :base (required) The branch (or git ref) you 
      # want your changes pulled into. This should be an existing branch on the 
      # current repository. You cannot submit a pull request to one repo that 
      # requests a merge to a base of another repo.
      # @option options [String] :head (required) The branch (or git ref) where 
      # your changes are implemented.
      # @return [Hash] The pull request information.
      # @see http://developer.github.com/v3/pulls/#create-a-pull-request
      # @example
      #   client.create_pull_request(
      #     'caseyscarborough',
      #     'github', 
      #     title: 'New pull request.', 
      #     head: 'caseyscarborough:new-feature', 
      #     base: 'master'
      #   )
      def create_pull_request(owner, repo, options={})
        post "/repos/#{owner}/#{repo}/pulls", body: options
      end

      # Update a pull request.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @param options [Hash] Optional parameters..
      # @option options [String] :title The pull request title.
      # @option options [String] :body
      # @option options [String] :state The state of the pull request, open or closed.
      # @return [Hash] The pull request information.
      # @see http://developer.github.com/v3/pulls/#update-a-pull-request
      def update_pull_request(owner, repo, number, options={})
        patch "/repos/#{owner}/#{repo}/pulls/#{number}", body: options
      end

      # List commits on a pull request.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Array] Array of commits as hashes.
      # @see http://developer.github.com/v3/pulls/#list-commits-on-a-pull-request
      def pull_request_commits(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}/commits"
      end

      # List pull requests files.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Array] Array of files as hashes.
      # @see http://developer.github.com/v3/pulls/#list-pull-requests-files
      def pull_request_files(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}/files"
      end

      # Check if a pull request has been merged.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Boolean] True if it has been merged, false if not.
      # @see http://developer.github.com/v3/pulls/#get-if-a-pull-request-has-been-merged
      def pull_request_merged?(owner, repo, number)
        boolean_request :get, "/repos/#{owner}/#{repo}/pulls/#{number}/merge"
      end

      # Merge a pull request.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Hash] Merge information.
      # @see http://developer.github.com/v3/pulls/#merge-a-pull-request-merge-buttontrade
      def merge_pull_request(owner, repo, number)
        put "/repos/#{owner}/#{repo}/pulls/#{number}/merge"
      end

      # List comments on a pull request.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Array] Array of comments as hashes.
      # @see http://developer.github.com/v3/pulls/comments/#list-comments-on-a-pull-request
      def pull_request_comments(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}/comments"
      end

      # List comments in a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name. 
      # @return [Array] Array of comments as hashes.
      # @see http://developer.github.com/v3/pulls/comments/#list-comments-in-a-repository
      def repo_pull_request_comments(owner, repo)
        get "/repos/#{owner}/#{repo}/pulls/comments"
      end

      # Get a single pull request comment.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name. 
      # @param number [Integer] Comment number.
      # @return [Hash] Comment information.
      # @see http://developer.github.com/v3/pulls/comments/#get-a-single-comment
      # @example
      #   GitHub.pull_request_comment('caseyscarborough', 'github', 1242348)
      def pull_request_comment(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/comments/#{number}"
      end

      # Create a pull request comment.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name. 
      # @param number [Integer] Pull request number.
      # @param options [Hash] Parameters.
      # @option options [String] :body (required) Comment body.
      # @option options [String] :commit_id (required) Sha of the commit to comment on.
      # @option options [String] :path (required) Relative path of the file to comment on.
      # @option options [Integer] :position (required) Line index in the diff to comment on.
      # @return [Hash] Comment information.
      # @see http://developer.github.com/v3/pulls/comments/#create-a-comment
      # @example
      #   client.create_pull_request_comment(
      #     'caseyscarborough',
      #     'github',
      #     3,
      #     body: 'Very nice!',
      #     commit_id: 'cbe5c38e933022534ea85c3c7e2596f1bb90fe8e',
      #     path: 'README.md',
      #     position: 2
      #   )
      def create_pull_request_comment(owner, repo, number, options={})
        post "/repos/#{owner}/#{repo}/pulls/#{number}/comments", body: options
      end

      # Edit a pull request comment.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name. 
      # @param number [Integer] Comment number.
      # @param body [String] New comment body.
      # @return [Hash] Comment information.
      # @see http://developer.github.com/v3/pulls/comments/#edit-a-comment
      # @example
      #   client.edit_pull_request_comment('caseyscarborough', 'github', 1242348, 'What up, girl?')
      def edit_pull_request_comment(owner, repo, number, body)
        options = { body: body }
        patch "/repos/#{owner}/#{repo}/pulls/comments/#{number}", body: options
      end

      # Delete a pull request comment.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name. 
      # @param number [Integer] Comment number.
      # @see http://developer.github.com/v3/pulls/comments/#delete-a-comment
      # @example
      #   client.delete_pull_request_comment('caseyscarborough', 'github', 1242348)
      def delete_pull_request_comment(owner, repo, number)
        boolean_request :delete, "/repos/#{owner}/#{repo}/pulls/comments/#{number}"
      end
    end

  end
end