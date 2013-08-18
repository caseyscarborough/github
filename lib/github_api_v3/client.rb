require 'json'
require 'github_api_v3/client/users'
require 'github_api_v3/client/repos'

module GitHub
  class Client

    include HTTParty
    base_uri Default::API_ENDPOINT

    include GitHub::Client::Users
    include GitHub::Client::Repos

    attr_reader :login, :access_token

    def initialize(options={})
      @login = options[:login]
      @access_token = options[:access_token] if options[:access_token]
      @password = options[:password] if options[:password]
    end

    private

      def get(url, params={})
        response = self.class.get url, query: params
        handle_response(response)
        response.parsed_response
      end

      def put(url, params={}, boolean=false)
        response = self.class.put url, query: params
        handle_response(response)
        boolean ? response.code == 204 : response.parsed_response
      end

      def post(url, params={}, body={}, boolean=false)
        response = self.class.post url, query: params, body: body.to_json
        handle_response(response)
        boolean ? response.code == 204 : response.parsed_response
      end

      def delete(url, params={}, boolean=false)
        response = self.class.delete url, query: params
        handle_response(response)
        boolean ? response.code == 204 : response.parsed_response
      end

      def basic_params
        @password.nil? ? {} : { login: @login, password: @password }
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