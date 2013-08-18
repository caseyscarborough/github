module GitHub
  
  # Default GitHub error.
  class GitHubError < StandardError; end

  # Raised when a 404 HTTP status code is received.
  class NotFound < GitHubError; end

  # Raised when a 401 HTTP status code is received.
  class Unauthorized < GitHubError; end

  # Raised when a 503 HTTP status code is received.
  class Unavailable < GitHubError; end

  # Raised when a 403 HTTP status code is received.
  class RateLimitExceeded < GitHubError; end

  # Raised when a 500..600 HTTP status code is received.
  class ServerError < GitHubError; end

  # Raised when a 400..500 HTTP status code is received.
  class ClientError < GitHubError; end
  
end