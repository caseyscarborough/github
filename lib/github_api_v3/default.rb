module GitHub

  # Default configuration information.
  module Default

    # The default API endpoint for GitHub's API.
    API_ENDPOINT = "https://api.github.com".freeze

    # The default web endpoint for GitHub.
    WEB_ENDPOINT = "https://github.com".freeze

  end
end

class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end
end
