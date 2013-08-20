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
        get "/repos/#{owner}/#{repo}/pulls", auth_params
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
        get "/repos/#{owner}/#{repo}/pulls/#{number}", auth_params
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
        post "/repos/#{owner}/#{repo}/pulls", auth_params, options
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
        patch "/repos/#{owner}/#{repo}/pulls/#{number}", auth_params, options
      end

      # List commits on a pull request.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Array] Array of commits as hashes.
      # @see http://developer.github.com/v3/pulls/#list-commits-on-a-pull-request
      def pull_request_commits(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}/commits", auth_params
      end

      # List pull requests files.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Array] Array of files as hashes.
      # @see http://developer.github.com/v3/pulls/#list-pull-requests-files
      def pull_request_files(owner, repo, number)
        get "/repos/#{owner}/#{repo}/pulls/#{number}/files", auth_params
      end

      # Check if a pull request has been merged.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param number [Integer] The pull request number.
      # @return [Boolean] True if it has been merged, false if not.
      # @see http://developer.github.com/v3/pulls/#get-if-a-pull-request-has-been-merged
      def pull_request_merged?(owner, repo, number)
        boolean_get "/repos/#{owner}/#{repo}/pulls/#{number}/merge", auth_params
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
        put "/repos/#{owner}/#{repo}/pulls/#{number}/merge", auth_params
      end
    end

  end
end