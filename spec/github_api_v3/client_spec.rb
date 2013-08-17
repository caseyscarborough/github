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
end