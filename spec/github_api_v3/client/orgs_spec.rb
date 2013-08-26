require 'spec_helper'

describe GitHub::Client::Orgs do

  describe '.organization', :vcr do
    it 'returns an organization' do
      org = GitHub.organization('github')
      org.should be_instance_of Hash
      org.name.should == "GitHub"
    end
  end

  describe '.edit_organization', :vcr do
    it 'returns an organization when successful' do
      org = test_client.edit_organization('api-test-organization', :name => 'API Test Organization')
      org.name.should == "API Test Organization"
      org.should be_instance_of Hash
    end
  end

  describe '.organization_members', :vcr do
    it 'returns an array' do
      GitHub.organization_members('rails').should be_instance_of Array
    end
  end

  describe '.organization_member?', :vcr do
    it 'returns false when user is not a member' do
      GitHub.organization_member?('rails','caseyscarborough').should be_false
    end

    it 'returns true when user is a member' do
      GitHub.organization_member?('rails','dhh').should be_true
    end
  end

  describe '.organization_public_members', :vcr do
    it 'returns an array' do
      GitHub.organization_public_members('rails').should be_instance_of Array
    end
  end

  describe '.organization_public_member?', :vcr do
    it 'returns false when user is not a member' do
      GitHub.organization_public_member?('rails','caseyscarborough').should be_false
    end

    it 'returns true when user is a member' do
      GitHub.organization_public_member?('rails','dhh').should be_true
    end
  end

  describe '.publicize_membership', :vcr do
    it 'publicizes a users membership' do
      test_client.publicize_membership('api-test-organization','caseyscarborough').should be_true
    end
  end

  describe '.unpublicize_membership', :vcr do
    it 'unpublicizes a users membership' do
      test_client.unpublicize_membership('api-test-organization','caseyscarborough').should be_true
    end
  end

  describe '.teams', :vcr do
    it 'returns a list of teams' do
      teams = test_client.teams('api-test-organization')
      teams.should be_instance_of Array
    end
  end

  describe '.team', :vcr do
    it 'returns a team' do
      team = test_client.team(478584)
      team.should be_instance_of Hash
      team.id.should == 478584
    end
  end

  team_id = ""
  describe '.create_team', :vcr do
    it 'creates a team' do
      new_team = test_client.create_team('api-test-organization', 'test-team')
      new_team.should be_instance_of Hash
      new_team.name.should == 'test-team'
      team_id = new_team.id
    end
  end

  describe '.edit_team', :vcr do
    it 'edits a team' do
      team = test_client.edit_team(team_id, 'new-team-name')
      team.should be_instance_of Hash
      team.name.should == 'new-team-name'
    end
  end

  describe '.delete_team', :vcr do
    it 'deletes a team' do
      test_client.delete_team(team_id).should be_true
      expect { test_client.team(team_id) }.to raise_error GitHub::NotFound
    end
  end

  describe '.team_members', :vcr do
    it 'returns a list of members' do
      members = test_client.team_members(478584)
      members.should be_instance_of Array
      members[0].login.should == "caseyscarborough"
    end
  end

  describe '.team_member?', :vcr do
    it 'determines membership' do
      test_client.team_member?(478584, 'caseyscarborough').should be_true
      test_client.team_member?(478584, 'random').should be_false
    end
  end

  describe '.add_team_member', :vcr do
    it 'adds a team member' do
      test_client.add_team_member(478584, 'api-test-user').should be_true
    end
  end

  describe '.remove_team_member', :vcr do
    it 'removes a team member' do
      test_client.remove_team_member(478584, 'api-test-user').should be_true
    end
  end 

  describe '.add_team_repo', :vcr do
    it 'adds a team repo' do
      test_client.add_team_repo(478584, 'api-test-organization', 'test-repo').should be_true
      test_client.team_repo?(478584, 'api-test-organization', 'test-repo').should be_true
    end
  end

  describe '.team_repos', :vcr do
    it 'returns a list of repos' do
      repos = test_client.team_repos(478584)
      repos.should be_instance_of Array
      repos[0].name.should == 'test-repo'
    end
  end

  describe '.team_repo?', :vcr do
    it 'determines if a repo is a team repo' do
      test_client.team_repo?(478584, 'api-test-organization', 'test-repo').should be_true
      test_client.team_repo?(478584, 'api-test-organization', 'not-a-test-repo').should be_false
    end
  end

  describe '.remove_team_repo', :vcr do
    it 'removes a team repo' do
      test_client.remove_team_repo(478584, 'api-test-organization', 'test-repo').should be_true
      test_client.team_repo?(478584, 'api-test-organization', 'test-repo').should be_false
    end
  end

end