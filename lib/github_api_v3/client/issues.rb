module GitHub
  class Client

    # Methods for the Issues API.
    #
    # @ see http://developer.github.com/v3/issues/
    module Issues

      # List all issues for an authenticated user, including owned, member, and org repos.
      #
      # Requires authentication.
      #
      # @param options [Hash] Optional parameters.
      # @option options [String] :filter assigned (default), created, mentioned, subscribed, all
      # @option options [String] :state open (default), closed
      # @option options [String] :labels String list of comma separated label names, ex. "bug,ui,@high"
      # @option options [String] :sort created (default), updated, comments
      # @option options [String] :directions asc (default), desc
      # @option options [String] :since Optional string of a timestamp in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
      # @return [Array] List of all issues.
      # @see http://developer.github.com/v3/issues/#list-issues
      # @example
      #   client.issues(:filter => 'created', :state => 'closed', :sort => 'updated')
      def issues(options={})
        get '/issues', :params => options
      end

      # List all issues across owned and member repositories for the authenticated user.
      #
      # Requires authentication.
      #
      # @param options [Hash] Optional parameters.
      # @option options [String] :filter assigned (default), created, mentioned, subscribed, all
      # @option options [String] :state open (default), closed
      # @option options [String] :labels String list of comma separated label names, ex. "bug,ui,@high"
      # @option options [String] :sort created (default), updated, comments
      # @option options [String] :directions asc (default), desc
      # @option options [String] :since Optional string of a timestamp in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
      # @return [Array] List of all issues.
      # @see http://developer.github.com/v3/issues/#list-issues
      # @example
      #   client.user_issues(:filter => 'created')
      def user_issues(options={})
        get '/user/issues', :params => options
      end

      # List all issues for a given organization for the authenticated user.
      #
      # Requires authentication.
      #
      # @param org [String] The organization name.
      # @param options [Hash] Optional parameters.
      # @option options [String] :filter assigned (default), created, mentioned, subscribed, all
      # @option options [String] :state open (default), closed
      # @option options [String] :labels String list of comma separated label names, ex. "bug,ui,@high"
      # @option options [String] :sort created (default), updated, comments
      # @option options [String] :directions asc (default), desc
      # @option options [String] :since Optional string of a timestamp in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
      # @return [Array] List of all issues.
      # @see http://developer.github.com/v3/issues/#list-issues
      # @example
      #   client.org_issues('facebook', :filter => 'mentioned', :state => 'closed')
      def org_issues(org, options={})
        get "/orgs/#{org}/issues", :params => options
      end

      # List issues for a repository.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param options [Hash] Optional parameters.
      # @option options [Integer, String] :milestone Milestone number (Integer), 'none', or '*' for issues with any milestone.
      # @option options [String] :state open (default), closed
      # @option options [String] :assignee User login, 'none', or '*' for issues with any milestone.
      # @option options [String] :creator User login
      # @option options [String] :mentioned User login
      # @option options [String] :labels String list of comma separated label names, ex. "bug,ui,@high"
      # @option options [String] :sort created (default), updated, comments
      # @option options [String] :directions asc (default), desc
      # @option options [String] :since Optional string of a timestamp in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
      # @return [Array] List of issues.
      # @see http://developer.github.com/v3/issues/#list-issues-for-a-repository
      # @example Closed repo issues since 2013-08-10 created by @caseyscarborough for the caseyscarborough/github repository.
      #   client.repo_issues(
      #     'caseyscarborough',
      #     'github', 
      #     :state => 'closed'
      #     :since => '2013-08-09T19:00:00-05:00'
      #   )
      def repo_issues(owner, repo, options={})
        get "/repos/#{owner}/#{repo}/issues"
      end

      # Get a single issue.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param number [Integer] The issue number.
      # @return [Hash]
      # @see http://developer.github.com/v3/issues/#get-a-single-issue
      # @example
      #   client.issue('caseyscarborough', 'github', 123)
      def issue(owner, repo, number)
        get "/repos/#{owner}/#{repo}/issues/#{number}"
      end

      # Create an issue.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param title [String] The issue title.
      # @param options [Hash] Parameters.
      # @option options [String] :body
      # @option options [String] :assignee Login for user to assign the issue to (must have push access).
      # @option options [Integer] :milestone The milestone to associate the issue with (must have push access).
      # @option options [Array] :labels Array of strings of labels to associate with this issue.
      # @return [Hash]
      # @see http://developer.github.com/v3/issues/#create-an-issue
      # @example
      #   client.create_issue('caseyscarborough', 'github', 'Found a bug', :assignee => 'caseyscarborough', :labels => ['label1', 'label2', 'label3'])
      def create_issue(owner, repo, title, options={})
        options.merge!(:title => title)
        post "/repos/#{owner}/#{repo}/issues", :body => options
      end

      # Edit an issue.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param number [Integer] The issue number.
      # @param options [Hash] Parameters.
      # @option options [String] :title
      # @option options [String] :body
      # @option options [String] :assignee Login for user to assign the issue to (must have push access).
      # @option options [String] :state open or closed
      # @option options [Integer] :milestone The milestone to associate the issue with (must have push access).
      # @option options [Array] :labels Array of strings of labels to associate with this issue.
      # @return [Hash] Issue information.
      # @see http://developer.github.com/v3/issues/#edit-an-issue
      # @example
      #   client.edit_issue('caseyscarborough', 'github', 3, body: 'This is the body.', state: 'closed')
      def edit_issue(owner, repo, number, options={})
        patch "/repos/#{owner}/#{repo}/issues/#{number}", :body => options
      end

      # List comments on an issue.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param number [Integer] The issue number.
      # @return [Array] A list of issue comments.
      # @see http://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
      def issue_comments(owner, repo, number)
        get "/repos/#{owner}/#{repo}/issues/#{number}/comments"
      end

      # List all issues comments for a repository.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @return [Array] A list of issue comments.
      # @see http://developer.github.com/v3/issues/comments/#list-comments-in-a-repository
      def issues_comments(owner, repo)
        get "/repos/#{owner}/#{repo}/issues/comments"
      end

      # Get a single issue comment.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param id [Integer] The comment ID.
      # @return [Hash] The comment information.
      # @see http://developer.github.com/v3/issues/comments/#get-a-single-comment
      def issue_comment(owner, repo, id)
        get "/repos/#{owner}/#{repo}/issues/comments/#{id}"
      end

      # Create a new issue comment.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param number [Integer] The issue number.
      # @param comment [String] The comment text.
      # @return [Hash] The comment information.
      # @see http://developer.github.com/v3/issues/comments/#create-a-comment
      def create_issue_comment(owner, repo, number, comment)
        post "/repos/#{owner}/#{repo}/issues/#{number}/comments", :body => { :body => comment }
      end

      # Edit an issue comment.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param id [Integer] The comment ID.
      # @param comment [String] The comment text.
      # @return [Hash] The comment information.
      # @see http://developer.github.com/v3/issues/comments/#edit-a-comment
      def edit_issue_comment(owner, repo, id, comment)
        patch "/repos/#{owner}/#{repo}/issues/comments/#{id}", :body => { :body => comment }
      end

      # Delete a comment.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param id [Integer] The comment ID.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/issues/comments/#delete-a-comment
      def delete_issue_comment(owner, repo, id)
        boolean_request :delete, "/repos/#{owner}/#{repo}/issues/comments/#{id}"
      end

      # List events for an issue.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param number [Integer] The issue number.
      # @return [Array] List of events.
      # @see http://developer.github.com/v3/issues/events/#list-events-for-an-issue
      def issue_events(owner, repo, number)
        get "/repos/#{owner}/#{repo}/issues/#{number}/events"
      end

      # Get a single issue event.
      #
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @param id [Integer] The event ID.
      # @see http://developer.github.com/v3/issues/events/#get-a-single-event
      def issue_event(owner, repo, id)
        get "/repos/#{owner}/#{repo}/issues/events/#{id}"
      end

    end
  end
end