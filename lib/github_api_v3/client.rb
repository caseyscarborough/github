require 'base64'
require 'json'
require 'github_api_v3/client/commits'
require 'github_api_v3/client/contents'
require 'github_api_v3/client/events'
require 'github_api_v3/client/feeds'
require 'github_api_v3/client/gists'
require 'github_api_v3/client/gitignore'
require 'github_api_v3/client/issues'
require 'github_api_v3/client/markdown'
require 'github_api_v3/client/milestones'
require 'github_api_v3/client/oauth'
require 'github_api_v3/client/octocat'
require 'github_api_v3/client/orgs'
require 'github_api_v3/client/pull_requests'
require 'github_api_v3/client/repos'
require 'github_api_v3/client/stats'
require 'github_api_v3/client/users'

module GitHub

  # The main client for the API.
  #
  # @see http://developer.github.com/v3/
  class Client

    include HTTParty

    # Default base uri for the API functionality.
    base_uri Default::API_ENDPOINT

    include GitHub::Client::Commits
    include GitHub::Client::Contents
    include GitHub::Client::Events
    include GitHub::Client::Feeds
    include GitHub::Client::Gitignore
    include GitHub::Client::Gists
    include GitHub::Client::Issues
    include GitHub::Client::Markdown
    include GitHub::Client::Milestones
    include GitHub::Client::OAuth
    include GitHub::Client::Octocat
    include GitHub::Client::Orgs
    include GitHub::Client::PullRequests
    include GitHub::Client::Repos
    include GitHub::Client::Stats
    include GitHub::Client::Users

    attr_accessor :login, :access_token, :password

    def initialize(options={})
      @login = options[:login]
      @access_token = options[:access_token] if options[:access_token]
      @password = options[:password] if options[:password]
    end

    private

      # Perform a get request.
      #
      # @return [Hash, Array, String]
      def get(url, options={})
        response = request :get, url, options
        handle_response(response)
        response.parsed_response
      end

      # Perform a put request.
      #
      # @return [Hash, Array, String]
      def put(url, options={})
        response = request :put, url, options
        handle_response(response)
        response.parsed_response
      end

      # Perform a post request.
      #
      # @return [Hash, Array, String]
      def post(url, options={})
        response = request :post, url, options
        handle_response(response)
        response.parsed_response
      end

      # Perform a patch request.
      #
      # @return [Hash, Array, String]
      def patch(url, options={})
        response = request :patch, url, options
        handle_response(response)
        response.parsed_response
      end

      # Perform a delete request.
      #
      # @return [Hash, Array, String]
      def delete(url, options={})
        response = request :delete, url, options
        handle_response(response)
        response.parsed_response
      end

      # Return a hash with client's login and password.
      #
      # @return [Hash]
      def basic_params
        @password.nil? ? {} : { :login => @login, :password => @password }
      end

      # Return a hash with client's login and access token.
      #
      # @return [Hash]
      def auth_params
        @login.nil? ? {} : { :login => @login, :access_token => @access_token }
      end

      def basic_auth_headers
        encoded_auth = Base64.encode64("#{@login}:#{@password}")
        { 'Authorization' => "Basic #{encoded_auth}" }
      end

      # Send an HTTP request.
      #
      # @param method [Symbol] The request type, such as :get, :put, or :post.
      # @param url [String] The URL to send the request to.
      # @param options [Hash] Optional parameters.
      # @option options [Hash] :params URL parameters.
      # @option options [Hash] :headers Headers to send with the request.
      # @option options [Hash] :body Body of the request.
      # @return [Array, Hash]
      # @example POST request
      #   request :post, 'http://example.com/users', params: { name: 'Casey' }, body: { example: 'example' }
      def request(method, url, options={})
        params    = options[:params]    || {}
        headers   = options[:headers]   || {}
        body      = options[:body]      || {}
        no_follow = options[:no_follow] || false

        params.merge!(auth_params)
        headers.merge!(basic_auth_headers) if @login && @password

        self.class.send(method, url, :query => params, :body => body.to_json, :headers => headers, :no_follow => no_follow)
      end

      # Get a boolean response from an HTTP request.
      #
      # @param method [Symbol] The request type, such as :get, :put, or :post.
      # @param url [String] The URL to send the request to.
      # @param options [Hash] Optional parameters.
      # @option options [Hash] :params URL parameters.
      # @option options [Hash] :headers Headers to send with the request.
      # @option options [Hash] :body Body of the request.
      # @return [Boolean]
      # @example DELETE Request
      #   boolean_request :delete, 'http://example.com/users'
      def boolean_request(method, url, options={})
        response = request(method, url, options)
        response.code == 204
      rescue GitHub::NotFound
        false
      end

      # Handle HTTP responses.
      #
      # Raise proper exceptions based on the response code.
      #
      # @return [HTTParty::Response]
      def handle_response(response)
        case response.code
        when 400 then raise BadRequest
        when 401 then raise Unauthorized
        when 403 
          if response.body =~ /rate limit/i
            raise RateLimitExceeded
          elsif response.body =~ /login attempts/i
            raise LoginAttemptsExceeded
          else
            raise Forbidden
          end
        when 404 then raise NotFound
        when 500 then raise InternalServerError
        when 502 then raise BadGateway
        when 503 then raise ServiceUnavailable
        when 500...600 then raise ServerError, response.code
        else
          response
        end
      end
  end
end