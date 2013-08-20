require 'spec_helper'

describe GitHub::Client::Stats do

  describe '.contributors_list', :vcr do
    it 'returns a list of contributors' do
      list = GitHub.contributors_list('ruby','ruby')
      list.should be_instance_of Array
      list.length.should == 31
    end
  end

  describe '.commit_activity', :vcr do
    it 'returns an array of commit info' do
      data = GitHub.commit_activity('caseyscarborough','github')
      data.should be_instance_of Array
      data.length.should == 52
    end
  end

  describe '.code_frequency', :vcr do
    it 'returns an array of additions and deletions' do
      data = GitHub.code_frequency('caseyscarborough','github')
      data.should be_instance_of Array
    end
  end

  describe '.participation', :vcr do
    it 'returns a hash of information' do
      data = GitHub.participation('caseyscarborough','github')
      data.should be_instance_of Hash
      data.owner.should be_instance_of Array
    end
  end

  describe '.punch_card', :vcr do
    it 'returns an array of data' do
      data = GitHub.punch_card('caseyscarborough','github')
      data.should be_instance_of Array
    end
  end

end