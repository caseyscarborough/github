require 'spec_helper'

describe GitHub::Client do

  let(:user) { GitHub.user('caseyscarborough') }

  subject { GitHub }

  it { should respond_to :user }
  it { should respond_to :events }
  it { should respond_to :followers }
  it { should respond_to :repos }

  describe 'default attributes' do
    it 'must include httparty' do
      GitHub::Client.should include(HTTParty)
    end

    it 'must have base URI set to GitHub API endpoint' do
      GitHub::Client.base_uri.should eq('https://api.github.com')
    end
  end

  describe 'get user data' do
    it 'should parse the API response from JSON to Hash' do
      user.should be_instance_of Hash
    end

    it 'should get the correct user info' do
      user['login'].should eq('caseyscarborough')
    end
  end

  describe 'event data' do
    it 'should return an array of events' do
      GitHub.events(user['login']).should be_instance_of Array
    end
  end

  describe 'followers' do
    it 'should return an array of users' do
      GitHub.followers(user['login']).should be_instance_of Array
    end
  end

  describe 'repositories' do
    it 'should return an array of repositories' do
      GitHub.repos(user['login']).should be_instance_of Array
    end
  end

  describe 'exceptions' do
end