module GitHub
  class Client

    # Contains methods for the Repos API.
    #
    # @see http://developer.github.com/v3/repos/
    module Repos
      
      # List all repositories
      #
      # Get a list of all repositories.
      #
      # @return [Array]
      # @see http://developer.github.com/v3/repos/#list-all-public-repositories
      def all_repos
        get '/repositories'
      end

      # Get one repository.
      #
      # @param owner [String] Username of repository owner.
      # @param repo [String] Name of repository.
      # @return [Hash] Repository information.
      # @see http://developer.github.com/v3/repos/#get
      # @example
      #   GitHub.repo('caseyscarborough','github')
      def repo(owner, repo)
        get "/repos/#{owner}/#{repo}"
      end

      # Get all repositories for a user.
      #
      # If authenticated, returns all repos for authenticated user.
      #
      # @param username [String] Username for repos owner.
      # @return [Array] List of repositories.
      # @see http://developer.github.com/v3/repos/#list-user-repositories
      # @example
      #   GitHub.repos('caseyscarborough')
      # @example
      #   client.repos
      def repos(username=nil)
        if username
          get "/users/#{username}/repos"
        else
          get '/user/repos', auth_params
        end
      end

      # Create a repository.
      #
      # Requires authentication.
      #
      # @param name [String] Repository name.
      # @param options [Hash] Repository information.
      # @option options [String] :description Repository description.
      # @option options [String] :homepage Repository homepage.
      # @option options [Boolean] :private
      # @option options [Boolean] :has_issues
      # @option options [Boolean] :has_wiki
      # @option options [Boolean] :has_downloads
      # @option options [Integer] :team_id ID of team
      # @option options [Boolean] :auto_init Create README.md automatically.
      # @option options [String] :gitignore_template Desired .gitignore template to apply.
      # @return [Hash] Repository information.
      # @see http://developer.github.com/v3/repos/#create
      # @example
      #   client.create_repo('new-repo', description: 'New repository.', private: true)
      def create_repo(name, options={})
        post "/user/repos", auth_params, options.merge(name: name)
      end

      # Delete a repository.
      # 
      # Requires authentication.
      #
      # @param repo [String] Name of repository to delete.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/repos/#delete-a-repository
      # @example
      #   client.delete_repo('repo-name')
      def delete_repo(owner, repo)
        boolean_delete "/repos/#{owner}/#{repo}", auth_params
      end

      # Get organization repositories.
      #
      # @param org [String] Organization name.
      # @return [Array] List of all repositories for org.
      # @see http://developer.github.com/v3/repos/#list-organization-repositories
      # @example
      #   GitHub.org_repos('rails')
      def org_repos(org)
        get "/orgs/#{org}/repos"
      end

      # List contributors for a repository.
      #
      # @param owner [String] Owner of repository.
      # @param repo [String] Repository name.
      # @return [Array] List of contributors.
      # @see http://developer.github.com/v3/repos/#list-contributors
      # @example
      #   GitHub.contributors('caseyscarborough','github')
      def contributors(owner, repo)
        get "/repos/#{owner}/#{repo}/contributors"
      end

      # List languages for a repository.
      #
      # @param owner [String] Owner of repository.
      # @param repo [String] Repository name.
      # @return [Hash] Language information.
      # @see http://developer.github.com/v3/repos/#list-languages
      # @example
      #   GitHub.languages('caseyscarborough','github')
      def languages(owner, repo)
        get "/repos/#{owner}/#{repo}/languages"
      end

      # def teams(owner, repo)
      #   get "/repos/#{owner}/#{repo}/teams"
      # end

      # List tags for a repository.
      #
      # @param owner [String] Owner of repository.
      # @param repo [String] Repository name.
      # @return [Array] List of tags and their information.
      # @see http://developer.github.com/v3/repos/#list-tags
      # @example
      #   GitHub.tags('caseyscarborough','github')
      def tags(owner, repo)
        get "/repos/#{owner}/#{repo}/tags"
      end

      # List branches for a repository.
      #
      # @param owner [String] Owner of repository.
      # @param repo [String] Repository name.
      # @return [Array] List of branches and their information. 
      # @see http://developer.github.com/v3/repos/#list-branches
      # @example
      #   GitHub.branches('caseyscarborough','github')
      def branches(owner, repo)
        get "/repos/#{owner}/#{repo}/branches"
      end

      # Get information about a branch.
      #
      # @param owner [String] Owner of repository.
      # @param repo [String] Repository name.
      # @param branch [String] Branch name.
      # @see http://developer.github.com/v3/repos/#get-branch
      # @example
      #   GitHub.branch('caseyscarborough','github','master')
      def branch(owner, repo, branch)
        get "/repos/#{owner}/#{repo}/branches/#{branch}"
      end

      # Get list of collaborators for a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Array] Array of collaborators.
      # @see http://developer.github.com/v3/repos/collaborators/#list
      # @example
      #   GitHub.collaborators('caseyscarborough','github')
      def collaborators(owner, repo)
        get "/repos/#{owner}/#{repo}/collaborators"
      end

      # Determine if a user is a collaborator to a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param user [String] User to check against.
      # @return [Boolean] True if user is a collaborator, false if not.
      # @see http://developer.github.com/v3/repos/collaborators/#get
      # @example
      #   GitHub.collaborator?('caseyscarborough','github','caseyscarborough')
      def collaborator?(owner, repo, user)
        boolean_get "/repos/#{owner}/#{repo}/collaborators/#{user}"
      end

      # Add a collaborator to a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param user [String] User to add.
      # @see http://developer.github.com/v3/repos/collaborators/#add-collaborator
      def add_collaborator(owner, repo, user)
        boolean_put "/repos/#{owner}/#{repo}/collaborators/#{user}", auth_params
      end

      # Remove a collaborator from a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param user [String] User to remove.
      # @see http://developer.github.com/v3/repos/collaborators/#remove-collaborator
      def remove_collaborator(owner, repo, user)
        boolean_delete "/repos/#{owner}/#{repo}/collaborators/#{user}", auth_params
      end

    end
  end
end