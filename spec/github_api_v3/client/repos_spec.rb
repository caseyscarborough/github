require 'spec_helper'

describe GitHub::Client::Repos do

  describe '.all_repos', :vcr do
    it 'returns an array of repositories' do
      GitHub.all_repos.should be_instance_of Array
    end
  end

  describe '.repo', :vcr do
    it 'returns a repo as a hash' do
      GitHub.repo('rails', 'rails').should be_instance_of Hash
    end
  end

  describe '.repos', :vcr do
    it 'returns an array of repositories' do
      GitHub.repos('caseyscarborough').should be_instance_of Array
    end

    it 'returns an array of repositories for authenticated user' do
      test_client.repos.should be_instance_of Array
    end
  end

  describe '.create_repo', :vcr do
    it 'returns a hash' do
      test_client.create_repo('098f6bcd4621d373cade4e832627b4f6').should be_instance_of Hash
    end

    it 'creates the repo' do
      GitHub.repo(test_client.login, '098f6bcd4621d373cade4e832627b4f6').should be_instance_of Hash
    end

    it 'returns unauthorized when not authorized' do
      expect { GitHub.create_repo('098f6bcd4621d373cade4e832627b4f6') }.to raise_error GitHub::Unauthorized
    end
  end

  describe '.edit_repo', :vcr do
    it 'returns a hash' do
      repo = test_client.edit_repo(test_client.login, '098f6bcd4621d373cade4e832627b4f6', :description => 'An awesome repo!')
      repo.should be_instance_of Hash
    end

    it 'edits the repository' do
      repo = GitHub.repo(test_client.login, '098f6bcd4621d373cade4e832627b4f6')
      repo.description.should == 'An awesome repo!'
    end

    it 'returns 404 when not authorized' do
      expect { GitHub.edit_repo(test_client.login, '098f6bcd4621d373cade4e832627b4f6') }.to raise_error GitHub::NotFound
    end
  end

  describe '.delete_repo', :vcr do
    it 'deletes a repo' do
      [true,false].should include test_client.delete_repo(test_client.login,'098f6bcd4621d373cade4e832627b4f6')
    end

    it 'returns false when not found', :vcr do
      test_client.delete_repo(test_client.login,'7ce4519eb32aa18d0917b0d407b53064').should be_false
    end

    it 'returns false if not authorized' do
      GitHub.delete_repo('caseyscarborough','github').should be_false
    end
  end

  describe '.org_repos', :vcr do
    it 'returns an array of repos' do
      GitHub.org_repos('rails').should be_instance_of Array
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.org_repos('7ce4519eb32aa18d0917b0d407b53064') }.to raise_error GitHub::NotFound
    end
  end

  describe '.contributors', :vcr do
    it 'returns an array of contributors' do
      GitHub.contributors('rails','rails').should be_instance_of Array
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.contributors('test','7ce4519eb32aa18d0917b0d407b53064') }.to raise_error GitHub::NotFound
    end
  end

  describe '.languages', :vcr do
    it 'returns a hash of languages' do
      GitHub.languages('rails','rails').should be_instance_of Hash
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.languages('test','7ce4519eb32aa18d0917b0d407b53064') }.to raise_error GitHub::NotFound
    end
  end

  # describe '.teams', :vcr do
  #   it 'returns an array of teams' do
  #     GitHub.teams('rails','rails').should be_instance_of Array
  #   end
  # end

  describe '.tags', :vcr do
    it 'returns an array of tags' do
      GitHub.tags('rails','rails').should be_instance_of Array
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.tags('test','7ce4519eb32aa18d0917b0d407b53064') }.to raise_error GitHub::NotFound
    end
  end

  describe '.branches', :vcr do
    it 'returns an array of branches' do
      GitHub.branches('rails', 'rails').should be_instance_of Array
    end
  end

  describe '.branch', :vcr do
    it 'returns a hash of branch info' do
      GitHub.branch('rails','rails','master').should be_instance_of Hash
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.branch('test','7ce4519eb32aa18d0917b0d407b53064','test') }.to raise_error GitHub::NotFound
    end
  end

  describe '.collaborators', :vcr do
    it 'returns a list of collaborators' do
      GitHub.collaborators('caseyscarborough','github').should be_instance_of Array
    end

    it 'returns a 404 if repo not found', :vcr do
      expect { GitHub.collaborators('test', '7ce4519eb32aa18d0917b0d407b53064') }.to raise_error GitHub::NotFound
    end
  end

  describe '.collaborator?', :vcr do
    it 'returns a boolean' do
      [true,false].should include GitHub.collaborator?('caseyscarborough','github','caseyscarborough')
    end
  end

  describe '.add_remove_collaborator', :vcr do
    before { test_client.create_repo('098f6bcd4621d373cade4e832627b4f6') }
    after  { test_client.delete_repo(test_client.login, '098f6bcd4621d373cade4e832627b4f6') }

    it 'adds a collaborator' do
      test_client.add_collaborator(test_client.login,'098f6bcd4621d373cade4e832627b4f6',test_client.login)
    end

    it 'removes a collaborator', :vcr do
      test_client.remove_collaborator(test_client.login,'098f6bcd4621d373cade4e832627b4f6',test_client.login)
    end
  end

  describe '.stargazers', :vcr do
    it 'returns a list of stargazers' do
      GitHub.stargazers('caseyscarborough','github').should be_instance_of Array
    end
  end

  describe '.unstar', :vcr do
    it 'unstars a repository' do
      test_client.unstar('caseyscarborough','github').should be_true
    end
  end

  describe '.star', :vcr do
    it 'stars a repository' do
      test_client.star('caseyscarborough','github').should be_true
    end
  end

  describe '.watchers', :vcr do
    it 'returns a list of watchers' do
      GitHub.watchers('caseyscarborough','github').should be_instance_of Array
    end
  end

  describe '.subscribe', :vcr do
    it 'subscribes to a repository' do
      test_client.subscribe('caseyscarborough','github').should be_instance_of Hash
    end
  end

  describe '.subscription', :vcr do
    before { test_client.subscribe('caseyscarborough','github') }
    it 'returns subscription information' do
      test_client.subscription('caseyscarborough','github').should be_instance_of Hash
    end
  end

  describe '.unsubscribe', :vcr do
    it 'unsubscribes to a repository' do
      test_client.unsubscribe('caseyscarborough','github').should be_true
    end
  end

  describe '.assignees', :vcr do
    let(:response) { test_client.assignees('caseyscarborough','github') }

    it 'returns an array of assignees' do
      response.should be_instance_of Array
    end

    it 'returns the correct information' do
      response[0].login.should == 'caseyscarborough'
    end
  end

  describe '.assignee?', :vcr do
    it 'returns true when the user is an assignee' do
      response = test_client.assignee?('caseyscarborough','github','caseyscarborough')
      response.should be_true
    end

    it 'returns false when the user is an assignee' do
      response = test_client.assignee?('caseyscarborough','github','random')
      response.should be_false
    end
  end

end