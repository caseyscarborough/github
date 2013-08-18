require 'spec_helper'

describe GitHub::Client::Events do

  describe '.public_events', :vcr do
    it 'returns an array of events' do
      GitHub.public_events.should be_instance_of Array
    end
  end

  describe '.repo_events', :vcr do
    it 'returns an array of events' do
      GitHub.repo_events('caseyscarborough','github').should be_instance_of Array
    end
  end

  describe '.repo_issue_events', :vcr do
    it 'returns an array of events' do
      GitHub.repo_issue_events('caseyscarborough','github').should be_instance_of Array
    end
  end

  describe '.repo_network_events', :vcr do
    it 'returns an array of events' do
      GitHub.repo_network_events('caseyscarborough','github').should be_instance_of Array
    end
  end

  describe '.organization_events', :vcr do
    it 'returns an array of events' do
      GitHub.organization_events('rails').should be_instance_of Array
    end
  end

  describe '.received_events', :vcr do
    it 'returns an array of events' do
      GitHub.received_events('caseyscarborough').should be_instance_of Array
    end
  end

  describe '.public_received_events', :vcr do
    it 'returns an array of events' do
      GitHub.public_received_events('caseyscarborough').should be_instance_of Array
    end
  end

  describe '.user_events', :vcr do
    it 'returns an array of events' do
      GitHub.user_events('caseyscarborough').should be_instance_of Array
    end
  end

  describe '.public_user_events', :vcr do
    it 'returns an array of events' do
      GitHub.public_user_events('caseyscarborough').should be_instance_of Array
    end
  end

  # Not a member of an organization, so can't really test this.
  # describe '.user_organization_events', :vcr do
  #   it 'returns an array of events' do
  #     test_client.user_organization_events('caseyscarborough').should be_instance_of Array
  #   end
  # end


end