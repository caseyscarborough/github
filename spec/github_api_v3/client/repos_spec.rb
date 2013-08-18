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
  end

  describe '.delete_repo', :vcr do
    it 'deletes a repo' do
      [true].should include test_client.delete_repo(test_client.login,'098f6bcd4621d373cade4e832627b4f6')
    end
  end

  describe '.org_repos', :vcr do
    it 'returns an array of repos' do
      GitHub.org_repos('rails').should be_instance_of Array
    end
  end

  describe '.contributors', :vcr do
    it 'returns an array of contributors' do
      GitHub.contributors('rails','rails').should be_instance_of Array
    end
  end

  describe '.languages', :vcr do
    it 'returns a hash of languages' do
      GitHub.languages('rails','rails').should be_instance_of Hash
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
  end

  describe '.collaborators', :vcr do
    it 'returns a list of collaborators' do
      GitHub.collaborators('caseyscarborough','github').should be_instance_of Array
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

end