module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    attr_reader :login, :access_token

    def initialize(options={})
      @login = options[:login]
      @access_token = options[:access_token]
    end

    # Users

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

    def events(username)
      get "/users/#{username}/events"
    end

    def repos(username)
      get "/users/#{username}/repos"
    end

    private

      def get(url, params={})
        response = self.class.get url, query: params
        handle_response(response)
        response.parsed_response
      end

      def put(url, params={})
        response = self.class.put url, query: params
        handle_response(response)
        response.parsed_response
      end

      def post(url, params={})
        response = self.class.post url, query: params
        response.code
      end

      def delete(url, params={})
        response = self.class.delete url, query: params
        handle_response(response)
        response.parsed_response
      end

      def auth_params
        @login.nil? ? {} : { login: @login, access_token: @access_token }
      end

      def handle_response(response)
        case response.code
        when 401 then raise Unauthorized
        when 403 then raise RateLimitExceeded
        when 404 then raise NotFound
        when 400..500 then raise ClientError
        when 500..600 then raise ServerError, response.code
        else
          response
        end
      end
  end
end