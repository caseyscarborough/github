module GitHub
  class Client

    module Repos
    
      def all_repos
        get '/repositories'
      end

      def repo(owner, repo)
        get "/repos/#{owner}/#{repo}"
      end

      def repos(username=nil)
        if username
          get "/users/#{username}/repos"
        else
          get '/user/repos', auth_params
        end
      end

      def create_repo(name, options = {})
        post "/user/repos", auth_params, options.merge(name: name)
      end

      # def delete_repo(owner, repo)
      #   delete "/repos/#{owner}/#{repo}", auth_params
      # end

      def org_repos(org)
        get "/orgs/#{org}/repos"
      end

      def contributors(owner, repo)
        get "/repos/#{owner}/#{repo}/contributors"
      end

      def languages(owner, repo)
        get "/repos/#{owner}/#{repo}/languages"
      end

      def teams(owner, repo)
        get "/repos/#{owner}/#{repo}/teams"
      end

      def tags(owner, repo)
        get "/repos/#{owner}/#{repo}/tags"
      end

      def branches(owner, repo)
        get "/repos/#{owner}/#{repo}/branches"
      end

      def branch(owner, repo, branch)
        get "/repos/#{owner}/#{repo}/branches/#{branch}"
      end
    end

  end
end