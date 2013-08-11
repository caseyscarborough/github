require 'spec_helper'

describe GitHub::Client do

  let(:user) { GitHub.user('caseyscarborough') }

  describe 'default attributes' do
    it 'must include httparty' do
      GitHub::Client.should include(HTTParty)
    end

    it 'must have base URI set to GitHub API endpoint' do
      GitHub::Client.base_uri.should eq('https://api.github.com')
    end
  end

  describe 'get user data' do
    it 'should respond to user method' do
      GitHub.should respond_to :user
    end

    it 'should parse the API response from JSON to OpenStruct' do
      user.should be_instance_of OpenStruct
    end

    it 'should get the correct user info' do
      user['login'].should eq('caseyscarborough')
    end
  end

  describe 'event data' do
    it 'should respond to events method' do
      GitHub.should respond_to :events
    end

    it 'should return an array of events' do
      GitHub.events(user['login']).should be_instance_of Array
    end
  end

  describe 'followers' do
    it 'should respond to followers method' do
      GitHub.should respond_to :followers
    end

    it 'should return an array of users' do
      GitHub.followers(user['login']).should be_instance_of Array
    end
  end

  describe 'repositories' do
    it 'should respond to repos method' do
      GitHub.should respond_to :repos
    end

    it 'should return an array of repositories' do
      GitHub.repos(user['login']).should be_instance_of Array
    end
  end
end