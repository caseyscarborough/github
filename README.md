# GitHub API v3 Wrapper

This is a simple wrapper for GitHub's v3 API. It is in the EARLY stages of development. Knowing a little about [GitHub's API](http://developer.github.com/) will aid in its use.

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

or install it manually:

```bash
$ gem install github-api-v3
```

Then you can proceed to use it in the following manner:

```ruby
require 'github'
# => true
```

#### User

Returns a Hash containing information about a user.

```ruby
user = GitHub.user('caseyscarborough')
user.login     # => "caseyscarborough"
user.name      # => "Casey Scarborough"
user.html_url  # => "https://github.com/caseyscarborough"
user.following # => 23
# etc...
```
You can find the available attributes [here](http://developer.github.com/v3/users/#get-a-single-user).

#### Events

Returns an array of events for a particular user.

```ruby
events = GitHub.events('caseyscarborough')
events.each { |e| puts e.type }
```

#### Followers

Returns an array of followers for a user.

```ruby
followers = GitHub.followers('caseyscarborough')
followers.each { |f| puts f.login }
```

#### Repositories

Returns an array of repositories that belong to a user.

```ruby
repos = GitHub.repos('caseyscarborough')
repos.each { |r| puts r.name }
```

### Authenticated Requests

Some methods, such as retrieving private repos or emails, require authentication. To create one of these requests, you'll need to pass in your login and access token. You can create a personal access token on your [account page](https://github.com/settings/applications).

```ruby
client = GitHub::Client.new(login: 'username', access_token: 'abcdefghijklmnopqrstuvwxyz12345')
client.emails # => ["email@example.com", "email2@example.com"]
```

More functionality to come.

## To Do

The better question is... What's not to do? Any functionality of the API listed at [developer.github.com](http://developer.github.com/) that isn't currently in effect.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
