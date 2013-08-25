module GitHub
  class Client

    # Methods for the Commits API.
    #
    # @see http://developer.github.com/v3/repos/commits/
    module Commits

      # List commits on a repository.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] Optional parameters.
      # @option options [String] :sha Sha or branch to start listing commits from.
      # @option options [String] :path Only commits containing this file path will be returned.
      # @option options [String] :author GitHub login, name, or email by which to filter by commit author.
      # @option options [String] :since ISO 8601 date to return commits after.
      # @option options [String] :until ISO 8601 date to return commits before.
      # @return [Array] A list of commits.
      # @see http://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
      def commits(owner, repo, options={})
        get "/repos/#{owner}/#{repo}/commits", params: options
      end

      # Get a single commit.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param sha [String] The SHA of the commit.
      # @return [Hash] The commit information.
      # @see http://developer.github.com/v3/repos/commits/#get-a-single-commit
      def commit(owner, repo, sha)
        get "/repos/#{owner}/#{repo}/commits/#{sha}"
      end

      # Compare two commits.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param base [String] The base SHA of the commit.
      # @param head [String] The head SHA of the commit.
      # @return [Hash] Comparison information.
      # @see http://developer.github.com/v3/repos/commits/#compare-two-commits
      def compare_commits(owner, repo, base, head)
        get "/repos/#{owner}/#{repo}/compare/#{base}...#{head}"
      end
    end

  end
end