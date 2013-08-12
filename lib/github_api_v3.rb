require 'httparty'
require 'github_api_v3/version'
require 'github_api_v3/error'
require 'github_api_v3/configuration'
require 'github_api_v3/client'

module GitHub

  class << self
    
    def client
      @client = Client.new unless @client
      @client
    end

  private 

    def method_missing(method_name, *args, &block)
      client.send(method_name, *args, &block)
    end

  end
end