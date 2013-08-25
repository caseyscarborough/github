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
          get '/user/repos'
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
        post "/user/repos", body: options.merge(name: name)
      end

      # Edit a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] Optional information.
      # @option options [String] :name The repository name.
      # @option options [String] :description Repository description.
      # @option options [String] :homepage Repository homepage.
      # @option options [Boolean] :private
      # @option options [Boolean] :has_issues
      # @option options [Boolean] :has_wiki
      # @option options [Boolean] :has_downloads
      # @option options [String] :default_branch The default branch.
      # @return [Hash] Repository information.
      # @see http://developer.github.com/v3/repos/#edit
      # @example
      #   client.edit_repo('caseyscarborough','github', name: 'github', description: 'An awesome repository!')
      def edit_repo(owner, repo, options={})
        options[:name] = repo unless options[:name]
        patch "/repos/#{owner}/#{repo}", body: options
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
        boolean_request :delete, "/repos/#{owner}/#{repo}"
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
        boolean_request :get, "/repos/#{owner}/#{repo}/collaborators/#{user}"
      end

      # Add a collaborator to a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param user [String] User to add.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/repos/collaborators/#add-collaborator
      def add_collaborator(owner, repo, user)
        boolean_request :put, "/repos/#{owner}/#{repo}/collaborators/#{user}"
      end

      # Remove a collaborator from a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @param user [String] User to remove.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/repos/collaborators/#remove-collaborator
      def remove_collaborator(owner, repo, user)
        boolean_request :delete, "/repos/#{owner}/#{repo}/collaborators/#{user}"
      end

      # List Stargazers for a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Array] List of users.
      # @see http://developer.github.com/v3/activity/starring/#list-stargazers
      # @example
      #   GitHub.stargazers('caseyscarborough','github')
      def stargazers(owner, repo)
        get "/repos/#{owner}/#{repo}/stargazers"
      end

      # Star a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/activity/starring/#star-a-repository
      def star(owner, repo)
        boolean_request :put, "/user/starred/#{owner}/#{repo}"
      end

      # Unstar a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/activity/starring/#unstar-a-repository
      def unstar(owner, repo)
        boolean_request :delete, "/user/starred/#{owner}/#{repo}"
      end

      # List Watchers for a repository.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Array] List of users.
      # @see http://developer.github.com/v3/activity/watching/#list-watchers
      def watchers(owner, repo)
        get "/repos/#{owner}/#{repo}/subscribers"
      end

      # Get subscription information.
      #
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Hash] Subscription information.
      # @see http://developer.github.com/v3/activity/watching/#get-a-repository-subscription
      # @example
      #   client.subscription('caseyscarborough','github')
      def subscription(owner, repo)
        get "/repos/#{owner}/#{repo}/subscription"
      end

      # Set a repository subscription.
      # 
      # Requires authentication.
      #
      # @param owner [String] Repository owner.
      # @param repo [String] Repository name.
      # @return [Hash] Subscription information.
      # @see http://developer.github.com/v3/activity/watching/#set-a-repository-subscription
      # @example
      #   client.subscribe('caseyscarborough','github')
      def subscribe(owner, repo, options={})
        options[:subscribed] = true unless options[:subscribed]
        options[:ignored] = false unless options[:ignored]
        put "/repos/#{owner}/#{repo}/subscription", body: options
      end

      # Delete a repository subscription.
      #
      # Requires authentication.
      #
      # @param repo [String] Repository name.
      # @return [Hash] Subscription information.
      # @see http://developer.github.com/v3/activity/watching/#delete-a-repository-subscription
      # @example
      #   client.unsubscribe('caseyscarborough','github')
      def unsubscribe(owner, repo)
        boolean_request :delete, "/repos/#{owner}/#{repo}/subscription"
      end
      
    end
  end
end