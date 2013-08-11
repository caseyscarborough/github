module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    def user(username)
      response = self.class.get "/users/#{username}"
      OpenStruct.new response
    end

    def followers(username)
      self.class.get "/users/#{username}/followers"
    end

    def events(username)
      self.class.get "/users/#{username}/events"
    end

    def repos(username)
      self.class.get "/users/#{username}/repos"
    end

  end
end