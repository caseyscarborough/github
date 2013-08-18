require 'spec_helper'

describe GitHub::Client::Users do

  describe '.user', :vcr do
    it 'returns a hash' do
       GitHub.user('caseyscarborough').should be_instance_of Hash
    end

    it 'gets the correct user info', :vcr do
      GitHub.user('caseyscarborough')['login'].should eq('caseyscarborough')
    end

    it 'returns a 404 if user not found' do
      expect { GitHub.user('098f6bcd4621d373cade4e832627b4f6') }.to raise_error GitHub::NotFound
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
    it 'returns true when following' do
      GitHub.follows?('caseyscarborough','matz').should be_true
    end

    it 'returns false when not following' do
      GitHub.follows?('caseyscarborough','caseyscarborough').should be_false
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

    it 'returns 404 for user not found' do
      expect { GitHub.keys('098f6bcd4621d373cade4e832627b4f6') }.to raise_error GitHub::NotFound
    end
  end

  describe '.key', :vcr do
    it 'returns a key' do
      test_client.key(5427887).should be_instance_of Hash
    end

    it 'returns unauthorized when not authorized' do
      expect { GitHub.key(5427887) }.to raise_error GitHub::Unauthorized
    end
  end

  key_id = ""
  describe '.create_key', :vcr do
    it 'returns the key information' do
      key = test_client.create_key('test-key','ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtABGJv4nOGmDZMUzlE1IJhI0d9rIivLv74ah5gpnQJls27WxjgntCr3JZQXX5msMmq1DFdnKmdBucksFf62xgCU0blBW0cFz40tlsfxrMUTxlt1ywaPdj4MD3PXMQsv8asE/gcRcAVCsVn1eOCLuPig4U90/iMr7anjVrwNhYF9RI5j5QxZt5G1e420zJNG23asjDLf37yepQRNWN/Q9Nuoz0o/2Dvs7JTGlI6lsPCxbgV3QrjFlOGpCJmCvMGW3HU7BoY286i/2ZWK9AHc5V1Mor9dQqd3B+WmWczbRYVRky9KYCCoCt9/y4oZ6GfYAyakGSV74JYxgSpcHr9BP3')
      key_id = key.id
      key.should be_instance_of Hash
    end
  end

  describe '.update_key', :vcr do
    it 'returns the key information' do
      key = test_client.update_key(key_id, 'test-key2', 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtABGJv4nOGmDZMUzlE1IJhI0d9rIivLv74ah5gpnQJls27WxjgntCr3JZQXX5msMmq1DFdnKmdBucksFf62xgCU0blBW0cFz40tlsfxrMUTxlt1ywaPdj4MD3PXMQsv8asE/gcRcAVCsVn1eOCLuPig4U90/iMr7anjVrwNhYF9RI5j5QxZt5G1e420zJNG23asjDLf37yepQRNWN/Q9Nuoz0o/2Dvs7JTGlI6lsPCxbgV3QrjFlOGpCJmCvMGW3HU7BoY286i/2ZWK9AHc5V1Mor9dQqd3B+WmWczbRYVRky9KYCCoCt9/y4oZ6GfYAyakGSV74JYxgSpcHr9BP4')
      key.should be_instance_of Hash
    end
  end

  describe '.delete_key', :vcr do
    it 'returns true or false' do
      [true,false].should include test_client.delete_key(key_id)
    end

    it 'should delete the key' do
      expect { test_client.key(key_id) }.to raise_error GitHub::NotFound
    end
  end

  describe '.starring', :vcr do
    it 'returns an unauthenticated users repos' do
      GitHub.starring('caseyscarborough').should be_instance_of Array
    end

    it 'returns an authenticated users repos' do
      test_client.starring.should be_instance_of Array
    end

    it 'returns a 404 for not found' do
      expect { GitHub.starring('098f6bcd4621d373cade4e832627b4f6') }.to raise_error GitHub::NotFound
    end
  end

end