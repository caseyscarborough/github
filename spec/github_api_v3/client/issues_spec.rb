require 'spec_helper'

describe GitHub::Client::Issues do

  describe '.issues', :vcr do
    let(:response) { test_client.issues(:filter => 'created') }

    it 'returns an array of issues' do
      response.should be_instance_of Array
      response[0].should be_instance_of Hash
    end

    it 'returns the correct information' do
      response[0].user.login.should == 'caseyscarborough'
    end
  end

  describe '.user_issues', :vcr do
    let(:response) { test_client.user_issues(:filter => 'created') }

    it 'returns an array of issues' do
      response.should be_instance_of Array
    end
  end

  describe '.org_issues', :vcr do
    let(:response) { test_client.org_issues('api-test-organization', :filter => 'created') }

    it 'returns an array of issues' do
      response.should be_instance_of Array
      response[0].should be_instance_of Hash
    end

    it 'returns the correct information' do
      response[0].user.login.should == 'caseyscarborough'
    end
  end

  describe '.repo_issues', :vcr do
    let(:response) { test_client.repo_issues('api-test-organization', 'test-repo') }

    it 'returns an array of issues' do
      response.should be_instance_of Array
      response[0].should be_instance_of Hash
    end

    it 'returns the correct information' do
      response[0].user.login.should == 'caseyscarborough'
    end
  end

  describe '.issue', :vcr do
    let(:response) { test_client.issue('api-test-organization', 'test-repo', 3) }

    it 'returns the issue information' do
      response.should be_instance_of Hash
    end

    it 'returns the correct information' do
      response.user.login.should == 'caseyscarborough'
    end
  end

  describe '.create_issue', :vcr do
    let(:response) { test_client.create_issue('api-test-organization', 'test-repo', 'Test issue.') }

    it 'returns the issue information' do
      response.should be_instance_of Hash
    end

    it 'returns the correct information' do
      response.title.should == 'Test issue.'
    end

    it 'creates the issue' do
      issue = test_client.issue('api-test-organization', 'test-repo', response.number)
      issue.should be_instance_of Hash
      issue.title.should == 'Test issue.'
    end
  end

  describe '.edit_issue', :vcr do
    let(:response) { test_client.edit_issue('api-test-organization', 'test-repo', 3, body: 'Updated body.') }

    it 'returns the issue information' do
      response.should be_instance_of Hash
    end

    it 'updates the issue' do
      issue = test_client.issue('api-test-organization', 'test-repo', 3)
      issue.body.should == 'Updated body.'
    end
  end


end