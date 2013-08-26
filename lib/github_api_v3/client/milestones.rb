module GitHub
  class Client

    # Methods for the Milestones API.
    #
    # @see http://developer.github.com/v3/issues/milestones
    module Milestones

      # List all milestones for a repository.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] Optional parameters.
      # @option options [String] :state open (default), closed
      # @option options [String] :sort due_date (default), completeness
      # @option options [String] :direction asc (default), desc
      # @return [Array] List of milestones.
      # @see http://developer.github.com/v3/issues/milestones/#list-milestones-for-a-repository
      # @example Without authentication.
      #   GitHub.milestones('caseyscarborough', 'github', :state => 'closed', :sort => 'completeness')
      # @example With authentication.
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.milestones('caseyscarborough', 'github', :state => 'closed', :sort => 'completeness')
      def milestones(owner, repo, options={})
        get "/repos/#{owner}/#{repo}/milestones", :params => options
      end

      # Get a single milestone.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param number [Integer] The milestone number.
      # @return [Hash] Milestone information.
      # @see http://developer.github.com/v3/issues/milestones/#get-a-single-milestone
      # @example Without authentication.
      #   GitHub.milestone('caseyscarborough', 'github', 3)
      # @example With authentication.
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.milestone('caseyscarborough', 'github', 3)
      def milestone(owner, repo, number)
        get "/repos/#{owner}/#{repo}/milestones/#{number}"
      end

      # Create a milestone.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param title [String] Milestone title.
      # @param options [Hash] Parameters.
      # @option options [String] :state open (default), closed
      # @option options [String] :description
      # @option options [String] :due_on ISO 8601 time.
      # @return [Hash] Milestone information.
      # @see http://developer.github.com/v3/issues/milestones/#create-a-milestone
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.create_milestone(
      #     'caseyscarborough',
      #     'github',
      #     'Milestone 1',
      #     :state  => 'open',
      #     :description => 'The newest milestone!',
      #     :due_on => '2013-08-25T16:31:30-04:00'
      #   )
      def create_milestone(owner, repo, title, options={})
        options.merge!(:title => title)
        post "/repos/#{owner}/#{repo}/milestones", :body => options
      end

      # Update a milestone.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param number [Integer] The milestone number.
      # @param options [Hash] Parameters.
      # @option options [String] :title
      # @option options [String] :state open (default), closed
      # @option options [String] :description
      # @option options [String] :due_on ISO 8601 time.
      # @return [Hash] The milestone information.
      # @see http://developer.github.com/v3/issues/milestones/#update-a-milestone
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.update_milestone(
      #     'caseyscarborough',
      #     'github',
      #     3,
      #     :title  => 'Milestone 1',
      #     :state  => 'closed',
      #     :description => 'Just a closed milestone.',
      #     :due_on => '2013-08-25T16:31:30-04:00'
      #   )
      def update_milestone(owner, repo, number, options={})
        options.merge!(:number => number)
        patch "/repos/#{owner}/#{repo}/milestones/#{number}", :body => options
      end
      alias :edit_milestone :update_milestone

      # Delete a milestone.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param number [Integer] The milestone number.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/issues/milestones/#delete-a-milestone
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.delete_milestone('caseyscarborough', 'github', 3)
      def delete_milestone(owner, repo, number)
        boolean_request :delete, "/repos/#{owner}/#{repo}/milestones/#{number}"
      end
    end

  end
end