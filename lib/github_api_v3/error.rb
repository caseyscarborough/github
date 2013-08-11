module GitHub
  
  class GitHubError < StandardError; end
  class NotFound < GitHubError; end
  class Unauthorized < GitHubError; end
  class Unavailable < GitHubError; end
  class RateLimitExceeded < GitHubError; end
  class ServerError < GitHubError; end
  class ClientError < GitHubError; end
  
end