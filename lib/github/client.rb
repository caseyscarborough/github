module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    def user(username)
      response = self.class.get "/users/#{username}"
      response.parsed_response
    end

    def followers(username)
      response = self.class.get "/users/#{username}/followers"
      response.parsed_response
    end

    def events(username)
      response = self.class.get "/users/#{username}/events"
      response.parsed_response
    end

    def repos(username)
      response = self.class.get "/users/#{username}/repos"
      response.parsed_response
    end

  end
end