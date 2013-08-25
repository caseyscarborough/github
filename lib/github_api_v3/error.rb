module GitHub
  
  # Default GitHub error.
  class GitHubError < StandardError; end

  # Raised when a 400 HTTP status code is received.
  class BadRequest < GitHubError; end

  # Raised when a 404 HTTP status code is received.
  class NotFound < GitHubError; end

  # Raised when a 401 HTTP status code is received.
  class Unauthorized < GitHubError; end

  # Raised when a 503 HTTP status code is received.
  class Unavailable < GitHubError; end

  # Raised when a 403 HTTP status code is received.
  class RateLimitExceeded < GitHubError; end

  # Raised when a 403 HTTP status code is received.
  class LoginAttemptsExceeded < GitHubError; end

  # Raised when a 403 HTTP status code is received.
  class Forbidden < GitHubError; end

  # Raised when a 500 HTTP status code is received.
  class InternalServerError < GitHubError; end

  # Raised when a 502 HTTP status code is received.
  class BadGateway < GitHubError; end

  # Raised when a 503 HTTP status code is received.
  class ServiceUnavailable < GitHubError; end

  # Raised when a 500...600 HTTP status code is received.
  class ServerError < GitHubError; end

  # Raised when a 400...500 HTTP status code is received.
  class ClientError < GitHubError; end
  
end