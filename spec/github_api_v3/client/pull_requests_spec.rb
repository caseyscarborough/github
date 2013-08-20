require 'spec_helper'

describe GitHub::Client::PullRequests do

  describe '.pull_requests', :vcr do
    it 'returns a list of pull requests' do
      pulls = GitHub.pull_requests('api-test-organization','test-repo')
      pulls.should be_instance_of Array
    end
  end

  describe '.pull_request', :vcr do
    it 'returns the right pull request' do
      pull = GitHub.pull_request('api-test-organization','test-repo', 1)
      pull.id.should == 7715395
      pull.title.should == "Test pull request."
    end
  end

  describe '.update_pull_request', :vcr do
    it 'updates a pull request' do
      pull = test_client.update_pull_request('api-test-organization','test-repo', 1, body: 'Test body update.')
      pull.should be_instance_of Hash
      pull.body.should == 'Test body update.'
    end
  end

  describe '.pull_request_commits', :vcr do
    it 'lists commits for a pull request' do
      commits = GitHub.pull_request_commits('api-test-organization','test-repo', 1)
      commits.should be_instance_of Array
      commits[0].sha.should == "d52551fa4167c89027beb15a1a15fed4eb7a00a6"
    end
  end

  describe '.pull_request_files', :vcr do
    it 'lists files for a pull request' do
      files = GitHub.pull_request_files('api-test-organization','test-repo', 1)
      files.should be_instance_of Array
      files[0].filename.should == 'README.md'
    end
  end

  describe '.pull_request_merged?', :vcr do
    it 'returns if a pull request has been merged' do
      GitHub.pull_request_merged?('api-test-organization','test-repo', 1).should be_false
    end
  end

  describe '.merge_pull_request', :vcr do
    it 'merges a pull request' do
      merge = test_client.merge_pull_request('api-test-organization','test-repo', 2)
      merge.should be_instance_of Hash
    end
  end
end