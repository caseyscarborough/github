module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    def user(username)
      response = self.class.get "/users/#{username}"
      handle_response(response)
      response.parsed_response
    end

    def followers(username)
      response = self.class.get "/users/#{username}/followers"
      handle_response(response)
      response.parsed_response
    end

    def events(username)
      response = self.class.get "/users/#{username}/events"
      handle_response(response)
      response.parsed_response
    end

    def repos(username)
      response = self.class.get "/users/#{username}/repos"
      handle_response(response)
      response.parsed_response
    end

    private

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