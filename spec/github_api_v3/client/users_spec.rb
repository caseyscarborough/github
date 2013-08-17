require 'spec_helper'

describe GitHub::Client::Users do

  describe '.user', :vcr do
    it 'returns a hash' do
        GitHub.user('caseyscarborough').should be_instance_of Hash
    end

    it 'gets the correct user info', :vcr do
        GitHub.user('caseyscarborough')['login'].should eq('caseyscarborough')
    end
  end

  describe '.users', :vcr do
    it 'returns an array' do
      GitHub.users.should be_instance_of Array
    end

    it 'returns an array of hashes', :vcr do
      GitHub.users[0].should be_instance_of Hash
    end
  end

  describe '.emails', :vcr do
    it 'returns an array of emails' do
      test_client.emails.should be_instance_of Array
    end
  end

  describe '.follow', :vcr do
    it 'follows a user' do
      follows = test_client.follow('caseyscarborough')
      [true, false].should include follows
    end
  end

  describe '.follows?', :vcr do
    it 'returns a boolean' do
      follows = GitHub.follows?('caseyscarborough', 'matz')
      [true, false].should include follows
    end
  end

  describe '.followers', :vcr do
    it 'returns authenticated users followers as an array' do
      test_client.followers.should be_instance_of Array
    end

    it 'returns unauthenticated users followers as an array' do
      GitHub.followers('caseyscarborough').should be_instance_of Array
    end
  end

  describe '.following', :vcr do
    it 'returns an array of followees' do
      GitHub.following('caseyscarborough').should be_instance_of Array
    end
  end

  describe '.following?', :vcr do
    it 'returns true or false' do
      following = test_client.following?('caseyscarborough')
      [true, false].should include following
    end
  end

  describe '.unfollow', :vcr do
    it 'unfollows a user' do
      unfollow = test_client.unfollow('caseyscarborough')
      [true, false].should include unfollow
    end
  end

  describe 'keys', :vcr do
    it 'returns an array of keys' do
      GitHub.keys('caseyscarborough').should be_instance_of Array
    end

    it 'returns an array of keys for authenticated user' do
      test_client.keys.should be_instance_of Array
    end
  end

  describe '.events', :vcr do
    it 'returns an array of events' do
      GitHub.events('caseyscarborough').should be_instance_of Array 
    end
  end

end