# GitHub API v3

[![Gem Version](https://badge.fury.io/rb/github_api_v3.png)](http://badge.fury.io/rb/github_api_v3)

This is a simple wrapper for GitHub's v3 API. It is in the EARLY stages of development. Knowing a little about [GitHub's API](http://developer.github.com/) will aid in its use.

## Documentation

Full documentation for the gem can be found at [rdoc.info/gems/github_api_v3/frames/index](http://rdoc.info/gems/github_api_v3/frames/index).

## Installation

To install the gem, issue the following command:

```bash
$ gem install github_api_v3
```

## Usage

```ruby
require 'github_api_v3'
```

### Unauthenticated Requests

There are multiple different unauthenticated requests to the API. These are performed when no credentials are given, and usually start with `GitHub`.


### Authenticated Requests

Some methods, such as retrieving private repos or emails, require authentication. To create one of these requests, you'll need to pass in your login and access token. You can create a personal access token on your [account page](https://github.com/settings/applications).

```ruby
client = GitHub::Client.new(login: 'username', access_token: 'abcdefghijklmnopqrstuvwxyz12345')
client.emails # => ["email@example.com", "email2@example.com"]
client.repos  # => #<Array:0x007fb8aa0d1a00>
client.follow('matz') # => true
client.user   # => #<Hash:0x007fb8a9109d70>
```

Anytime a method is shown below starting with `client`, it is an authenticated method.

### Sample usage

#### Users

The following are some sample usages of the Users module.

```ruby
# Retrieve a single user
user = GitHub.user('caseyscarborough')
user.login     # => "caseyscarborough"
user.name      # => "Casey Scarborough"
user.html_url  # => "https://github.com/caseyscarborough"
user.following # => 23

# Retrieve an array of all GitHub users
GitHub.users

# Get emails for authenticated user
client.emails

# Follow/unfollow a user
client.follow('caseyscarborough')
client.unfollow('caseyscarborough')

# Check if a user follows another user
GitHub.follows?('caseyscarborough','matz')

# Get a list of an unauthenticated user's followers
GitHub.followers('caseyscarborough')

# Get a list of an authenticated user's followers
client.followers

# Get a list of user's a user is following
GitHub.following('caseyscarborough')

# See if authenticated user is following another user
client.following?('caseyscarborough')

# Get events for a user
GitHub.events('caseyscarborough')

# etc...
```
You can find the available attributes [here](http://developer.github.com/v3/users/#get-a-single-user). Check the [Users documentation](http://rdoc.info/gems/github_api_v3/GitHub/Client/Users) for the gem for a complete list and more examples.

#### Repositories

The following are some sample usages for the Repos module.

```ruby
# Get repos for an unauthenticated/authenticated user
GitHub.repos('caseyscarborough')
client.repos

# Get all public repos on GitHub
GitHub.all_repos

# Get a specific repo
GitHub.repo('owner','repo-name')

# Create a repo
client.create_repo('new-repo', description: 'New repository.', private: true)

# Delete a repo
client.delete_repo('repo-name')

# Get a repository's contributors/languages/tags/branches/collaborators
GitHub.contributors('caseyscarborough','github')
GitHub.languages('caseyscarborough','github')
GitHub.tags('caseyscarborough','github')
GitHub.branches('caseyscarborough','github')
GitHub.collaborators('caseyscarborough','github')

# Get a specific branch
GitHub.branch('caseyscarborough','github','master')

# Add/remove collaborator
client.add_collaborator('owner','repo-name','user-to-add')
client.remove_collaborator('owner','repo-name','user-to-remove')
```
For a full list with descriptions, see the [Repos documentation](http://rdoc.info/gems/github_api_v3/GitHub/Client/Repos) for the gem.

#### Gists

The following are sample uses for the Gists module.

```ruby
# Get all gists for a user
GitHub.gists('caseyscarborough')

# Get all gists for authenticated user
client.gists

# Get all public gists
GitHub.gists

# Get a gist by id
GitHub.gist(1234567)

# Create a gist
client.create_gist(
  files: {"file1.txt" => { content: "File contents" }}, 
  description: "Gist description", 
  public: "false"
)

# Check if a gist is starred
client.gist_starred?(1234567)

# Star/unstar/fork/delete a gist
client.star_gist(1234567)
client.unstar_gist(1234567)
client.fork_gist(1234567)
client.delete_gist(1234567)
```
Check out the [Gist documentation](http://rdoc.info/gems/github_api_v3/GitHub/Client/Gists) for more information.

## Running the Test Suite

The test suite can be run by issuing the following command from the root of the directory:

```bash
$ rspec spec/
```

## To Do

The better question is... What's not to do? Any functionality of the API listed at [developer.github.com](http://developer.github.com/) that isn't currently in effect.

Some main missing functionality:
* A good bit of the [Repos API](http://developer.github.com/v3/repos/), such as:
  * Comments
  * Commits
  * Hooks
  * Forks
  * etc.
* Markdown
* Editing Gists
* Editing Repos
* Updating User keys

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
