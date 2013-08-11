module GitHub
  class Client

    include HTTParty
    base_uri Configuration::DEFAULT_ENDPOINT

    def user(username=nil)
      response = self.class.get("/users/#{username}").parsed_response
      OpenStruct.new response
    end

    def events(username=nil)
      self.class.get("/users/#{username}/events").parsed_response
    end

  end
end