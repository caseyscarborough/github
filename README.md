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

Returns a OpenStruct (hash) containing information about a user.

```ruby
user = GitHub.user('caseyscarborough')
user.login
# => "caseyscarborough"
user.html_url
# => "https://github.com/caseyscarborough"
# ...etc
```

#### Events

Returns an array of events for a particular user.

```ruby
events = GitHub.events('caseyscarborough')
events.each do |e|
  puts e['type']
end
```

#### Followers

Returns an array of followers for a user.

```ruby
followers = GitHub.followers('caseyscarborough')
followers.each do |f|
  puts f['login']
end
```

##### Repositories

Returns an array of repositories that belong to a user.

```ruby
repos = GitHub.repos('caseyscarborough')
# => ...array of repositories
repos.each do |r|
  puts r['name']
end
```

More functionality to come.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
