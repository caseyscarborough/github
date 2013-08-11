require 'httparty'
require 'ostruct'
require 'github/version'
require 'github/configuration'
require 'github/client'

module GitHub

  class << self
    
    def user(username)
      Client.new.user(username)
    end

    def followers(username)
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