 module GitHub
  class Client

    module Users
      def user(username=nil)
        if username
          get "/users/#{username}"
        else
          get '/user', auth_params
        end
      end

      def users
        get '/users'
      end

      # Get emails for authenticated user
      def emails
        get '/user/emails', auth_params
      end

      def follow(username)
        put "/user/following/#{username}", auth_params
      end

      def follows?(username, target_username)
        response = self.class.get "/users/#{username}/following/#{target_username}"
        response.code == 204
      end

      def followers(username=nil)
        if username
          get "/users/#{username}/followers"
        else
          get '/user/followers', auth_params
        end
      end

      def following(username)
        get "/users/#{username}/following"
      end

      def following?(username)
        response = self.class.get "/user/following/#{username}", query: auth_params
        response.code == 204
      end

      def unfollow(username)
        delete "/user/following/#{username}", auth_params
      end

      def keys(username=nil)
        if username
          get "/users/#{username}/keys"
        else
          get '/user/keys', auth_params
        end
      end

      def key(id)
        get "/user/keys/#{id}", auth_params
      end

      def delete_key(id)
        delete "/user/keys/#{id}", auth_params
      end
    end
  
  end
end