module GitHub
  class Client

    # Methods for the Repo Statistics API.
    #
    # A notice about caching from GitHub's API:
    # Computing repository statistics is an expensive operation, so we 
    # try to return cached data whenever possible. If the data hasn’t 
    # been cached when you query a repository’s statistics, you’ll receive 
    # a 202 response; a background job is also fired to start compiling these 
    # statistics. Give the job a few moments to complete, and then submit the 
    # request again. If the job has completed, that request will receive a 
    # 200 response with the statistics in the response body.
    # Repository statistics are cached by the SHA of the repository’s default 
    # branch, which is usually master; pushing to the default branch resets 
    # the statistics cache.
    #
    # @see http://developer.github.com/v3/repos/statistics/
    module Stats

      # @see http://developer.github.com/v3/repos/statistics/#get-contributors-list-with-additions-deletions-and-commit-counts
      def contributors_list(owner, repo)
        get "/repos/#{owner}/#{repo}/stats/contributors", auth_params
      end

      # @see http://developer.github.com/v3/repos/statistics/#get-the-last-year-of-commit-activity-data
      def commit_activity(owner, repo)
        get "/repos/#{owner}/#{repo}/stats/commit_activity", auth_params
      end

      # @see http://developer.github.com/v3/repos/statistics/#get-the-number-of-additions-and-deletions-per-week
      def code_frequency(owner, repo)
        get "/repos/#{owner}/#{repo}/stats/code_frequency", auth_params
      end

      # @see http://developer.github.com/v3/repos/statistics/#get-the-weekly-commit-count-for-the-repo-owner-and-everyone-else
      def participation(owner, repo)
        get "/repos/#{owner}/#{repo}/stats/participation", auth_params
      end

      # @see http://developer.github.com/v3/repos/statistics/#get-the-number-of-commits-per-hour-in-each-day
      def punch_card(owner, repo)
        get "/repos/#{owner}/#{repo}/stats/punch_card", auth_params
      end

    end

  end
end