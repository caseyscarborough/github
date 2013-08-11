module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    attr_reader :login, :access_token

    def initialize(login=nil, access_token=nil)
      @login = login
      @access_token = access_token
    end

    def user(username)
      get "/users/#{username}"
    end

    def users
      get "/users"
    end

    # Get emails for authenticated user
    def emails
      get "/user/emails", auth_params
    end

    def followers(username)
      get "/users/#{username}/followers"
    end

    def following(username)
      get "/users/#{username}/following"
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