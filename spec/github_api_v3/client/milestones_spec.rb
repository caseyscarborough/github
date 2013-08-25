require 'spec_helper'

describe GitHub::Client::Milestones do

  describe '.milestones', :vcr do
    let(:response) { test_client.milestones('caseyscarborough', 'github') }

    it 'returns a list of milestones' do
      response.should be_instance_of Array
    end
  end

  describe '.milestone', :vcr do
    let(:response) { test_client.milestone('rails', 'rails', 25) }

    it 'returns a milestone as a hash' do
      response.should be_instance_of Hash
    end

    it 'returns the correct milestone' do
      response.number.should == 25
    end
  end

  milestone_number = ""
  describe '.create_milestone', :vcr do
    let(:response) { test_client.create_milestone('api-test-organization', 'test-repo', 'Milestone 3') }

    it 'returns a milestone as a hash' do
      response.should be_instance_of Hash
      milestone_number = response.number
    end

    it 'creates the milestone' do
      milestone = test_client.milestone('api-test-organization', 'test-repo', milestone_number)
      milestone.title.should == 'Milestone 3'
    end
  end

  describe '.update_milestone', :vcr do
    let(:response) { test_client.update_milestone('api-test-organization', 'test-repo', milestone_number, :description => 'The first milestone.') }

    it 'returns a milestone as a hash' do
      response.should be_instance_of Hash
    end

    it 'updates the milestone' do
      milestone = test_client.milestone('api-test-organization', 'test-repo', milestone_number)
      milestone.description.should == 'The first milestone.'
    end
  end

  describe '.delete_milestone', :vcr do
    let(:response) { test_client.delete_milestone('api-test-organization', 'test-repo', milestone_number) }

    it 'returns true' do
      response.should be_true
    end

    it 'deletes the milestone' do
      expect { test_client.milestone('api-test-organization', 'test-repo', milestone_number) }.to raise_error GitHub::NotFound
    end
  end

end