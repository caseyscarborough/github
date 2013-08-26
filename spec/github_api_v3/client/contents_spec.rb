require 'spec_helper'

describe GitHub::Client::Contents do

  describe '.readme', :vcr do
    let(:response) { test_client.readme('caseyscarborough', 'github') }

    it 'returns a readme hash' do
      response.should be_instance_of Hash
    end

    it 'returns the correct file' do
      response.name.should == "README.md"
    end
  end

  describe '.contents', :vcr do
    let(:file_response) { test_client.contents('caseyscarborough','github','README.md') }
    let(:dir_response) { test_client.contents('caseyscarborough','github','lib') }

    it 'returns a hash for a file' do
      file_response.should be_instance_of Hash
    end

    it 'returns an array for a dir' do
      dir_response.should be_instance_of Array
    end

    it 'returns the correct file hash' do
      file_response.name.should == "README.md"
    end

    it 'returns a 404 if not found' do
      expect { test_client.contents('caseyscarborough','github','asdf') }.to raise_error GitHub::NotFound
    end
  end

  filepath = 'testfile.txt'
  sha = ''
  describe '.create_file', :vcr do
    let(:response) { 
      test_client.create_file(
        'api-test-organization',
        'test-repo',
        :path => filepath,
        :message => 'Test file creation using github_api_v3 gem.',
        :content => 'This file is a test.',
        :sha => '',
        :committer => { :name => 'Casey Scarborough', :email => 'caseyscarborough@gmail.com' }
      )
    }

    it 'returns file info as a hash' do
      response.should be_instance_of Hash
      sha = response.content.sha
    end
  end

  describe '.update_file', :vcr do
    let(:response) {
      test_client.update_file(
        'api-test-organization',
        'test-repo',
        :path      => filepath,
        :message   => 'Test file update using github_api_v3 gem.',
        :content   => 'This file is a test, and has now been updated.',
        :sha       => sha,
        :committer => { :name => 'Casey Scarborough', :email => 'caseyscarborough@gmail.com' }
      )
    }

    it 'returns file info as a hash' do
      response.should be_instance_of Hash
      sha = response.content.sha
    end

    it 'returns the correct hash' do
      response.content.name.should == filepath
    end
  end

  describe '.delete_file', :vcr do
    it 'returns a hash' do
      response = test_client.delete_file(
        'api-test-organization',
        'test-repo',
        :path      => filepath,
        :message   => 'Delete testfile',
        :sha       => sha,
        :committer => { :name => 'Casey Scarborough', :email => 'casey@example.com' }
        )
      response.should be_instance_of Hash
    end

    it 'deletes the file' do
      expect { test_client.contents('api-test-organization','test-repo',filepath) }.to raise_error GitHub::NotFound 
    end
  end

  describe '.archive', :vcr do
    let(:response) { GitHub.archive('caseyscarborough', 'github', 'tarball') }

    it 'returns a string' do
      response.should be_instance_of String
    end

    it 'returns the correct string' do
      response.should == "https://codeload.github.com/caseyscarborough/github/legacy.tar.gz/master"
    end
  end
end