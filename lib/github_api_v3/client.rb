require 'json'
require 'github_api_v3/client/events'
require 'github_api_v3/client/feeds'
require 'github_api_v3/client/gists'
require 'github_api_v3/client/gitignore'
require 'github_api_v3/client/markdown'
require 'github_api_v3/client/orgs'
require 'github_api_v3/client/repos'
require 'github_api_v3/client/users'

module GitHub

  # The main client for the API.
  #
  # @see http://developer.github.com/v3/
  class Client

    include HTTParty

    # Default base uri for the API functionality.
    base_uri Default::API_ENDPOINT

    include GitHub::Client::Events
    include GitHub::Client::Feeds
    include GitHub::Client::Gitignore
    include GitHub::Client::Gists
    include GitHub::Client::Markdown
    include GitHub::Client::Orgs
    include GitHub::Client::Repos
    include GitHub::Client::Users

    attr_reader :login, :access_token

    def initialize(options={})
      @login = options[:login]
      @access_token = options[:access_token] if options[:access_token]
      @password = options[:password] if options[:password]
    end

    private

      # Perform a get request.
      #
      # @return [Hash, Array, String]
      def get(url, params={})
        response = self.class.get url, query: params
        handle_response(response)
        response.parsed_response
      end

      # Perform a get request with boolean return type.
      #
      # @return [Boolean]
      def boolean_get(url, params={})
        response = self.class.get url, query: params
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Perform a put request.
      #
      # @return [Hash, Array, String]
      def put(url, params={}, body={})
        response = self.class.put url, query: params, body: body.to_json
        handle_response(response)
        response.parsed_response
      end

      # Perform a put request with boolean return type.
      #
      # @return [Boolean]
      def boolean_put(url, params={}, body={})
        response = self.class.put url, query: params, body: body.to_json
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Perform a post request.
      #
      # @return [Hash, Array, String]
      def post(url, params={}, body={})
        response = self.class.post url, query: params, body: body.to_json
        handle_response(response)
        response.parsed_response
      end

      # Perform a post request with boolean return type.
      #
      # @return [Boolean]
      def boolean_post(url, params={}, body={})
        response = self.class.post url, query: params, body: body.to_json
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Perform a patch request.
      #
      # @return [Hash, Array, String]
      def patch(url, params={}, body={})
        response = self.class.patch url, query: params, body: body.to_json
        handle_response(response)
        response.parsed_response
      end

      # Perform a patch request with boolean return type.
      #
      # @return [Boolean]
      def boolean_patch(url, params={}, body={})
        response = self.class.patch url, query: params, body: body.to_json
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Perform a delete request.
      #
      # @return [Hash, Array, String]
      def delete(url, params={})
        response = self.class.delete url, query: params
        handle_response(response)
        response.parsed_response
      end

      # Perform a delete request with boolean return type.
      #
      # @return [Boolean]
      def boolean_delete(url, params={})
        response = self.class.delete url, query: params
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Return a hash with client's login and password.
      #
      # @return [Hash]
      def basic_params
        @password.nil? ? {} : { login: @login, password: @password }
      end

      # Return a hash with client's login and access token.
      #
      # @return [Hash]
      def auth_params
        @login.nil? ? {} : { login: @login, access_token: @access_token }
      end

      # Handle HTTP responses.
      #
      # Raise proper exceptions based on the response code.
      #
      # @return [HTTParty::Response]
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