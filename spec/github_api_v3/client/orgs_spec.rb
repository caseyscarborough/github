require 'spec_helper'

describe GitHub::Client::Orgs do

  describe '.organization', :vcr do
    it 'returns an organization' do
      GitHub.organization('github').should be_instance_of Hash
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
      test_client.publicize_membership('test_organization','caseyscarborough').should be_true
    end
  end

  describe '.unpublicize_membership', :vcr do
    it 'unpublicizes a users membership' do
      test_client.unpublicize_membership('test_organization','caseyscarborough').should be_true
    end
  end

end