# GitHub API v3 Wrapper

This is a simple wrapper for GitHub's v3 API. It is in the EARLY stages of development.

## Installation

As of right now, the library has not reached a version which I consider worth pushing to RubyGems.org. Feel free to clone the repository and build the gem and install it if you wish:

```bash
$ git clone https://github.com/caseyscarborough/github && cd github
$ gem build github-api-v3.gemspec
$ gem install github-api-v3-0.0.1.gem
```

## Usage

Add the following line to your gemfile:

```ruby
gem 'github-api-v3'
```

Then you can proceed to use it in the following manner:

#### User

```ruby
user = GitHub.user('caseyscarborough')
user.login
# => "caseyscarborough"
user.html_url
# => "https://github.com/caseyscarborough"
# ...etc
```

#### Events
```ruby
events = GitHub.events('caseyscarborough')
events.each do |e|
  puts e['type']
end
```

More functionality to come.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
