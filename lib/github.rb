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

    def events(username)
      Client.new.events(username)
    end

  end
end