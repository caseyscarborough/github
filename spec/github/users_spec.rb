require 'spec_helper'

describe GitHub::Users do

  let(:user) { GitHub::Users.new('caseyscarborough') }

  describe 'default attributes' do
    it 'must include httparty' do
      GitHub::Users.should include(HTTParty)
    end

    it 'must have base URI set to GitHub API endpoint' do
      GitHub::Users.base_uri.should eq('https://api.github.com')
    end
  end

  describe 'get user data' do
    it 'should respond to info method' do
      user.should respond_to :info
    end

    it 'should parse the API response from JSON to Hash' do
      user.info.should be_instance_of Hash
    end

    it 'should get the correct user info' do
      user.info['login'].should eq('caseyscarborough')
    end
  end

  describe 'dynamic attributes' do
    before { user.info }

    it 'should return the id' do
      user.id.should eq(3237612)
    end

    it 'should raise method missing if attribute doesn\'t exist' do
      lambda { user.fake_attribute }.should raise_error(NoMethodError)
    end
  end

end