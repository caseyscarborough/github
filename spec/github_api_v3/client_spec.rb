require 'spec_helper'

describe GitHub::Client do

  subject { GitHub::Client }

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
      VCR.use_cassette 'users/user' do
        GitHub.user('caseyscarborough').should be_instance_of Hash
      end
    end

    it 'should get the correct user info' do
      VCR.use_cassette 'users/user' do
        GitHub.user('caseyscarborough')['login'].should eq('caseyscarborough')
      end
    end
  end

  describe 'event data' do
    it 'should return an array of events' do
      VCR.use_cassette 'users/events' do
        GitHub.events('caseyscarborough').should be_instance_of Array 
      end
    end
  end

  describe 'followers' do
    it 'should return an array of users' do
      VCR.use_cassette 'users/followers' do
        GitHub.followers('caseyscarborough').should be_instance_of Array
      end
    end
  end

  describe 'repositories' do
    it 'should return an array of repositories' do
      VCR.use_cassette 'users/repos' do
        GitHub.repos('caseyscarborough').should be_instance_of Array
      end
    end
  end
end