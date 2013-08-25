require 'spec_helper'

describe GitHub::Client::Commits do

  describe '.commits', :vcr do
    let(:response) { test_client.commits('caseyscarborough', 'github') }

    it 'returns an array of commits' do
      response.should be_instance_of Array
    end
  end

  describe '.commit', :vcr do
    let(:response) { test_client.commit('caseyscarborough', 'github', '03cfc64392') }

    it 'returns a commit as a hash' do
      response.should be_instance_of Hash
    end
  end

  describe '.compare_commits', :vcr do
    let(:response) { test_client.compare_commits('caseyscarborough','github','09ba5bc078','03cfc64392') }

    it 'returns a hash of commit comparison' do
      response.should be_instance_of Hash
    end
  end

end