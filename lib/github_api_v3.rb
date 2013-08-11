require 'httparty'
require 'github_api_v3/version'
require 'github_api_v3/error'
require 'github_api_v3/configuration'
require 'github_api_v3/client'

module GitHub

  class << self
    
    def user(username)
      Client.new.user(username)
    end

    def users
      Client.new.users
    end

    def followers(username=nil)
      Client.new.followers(username)
    end

    def events(username)
      Client.new.events(username)
    end

    def repos(username)
      Client.new.repos(username)
    end

  end
end