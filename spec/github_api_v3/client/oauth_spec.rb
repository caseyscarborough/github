require 'spec_helper'

describe GitHub::Client::OAuth do

  describe '.authorizations', :vcr do
    let(:response) { test_basic_client.authorizations }
    
    it 'returns a list of authorizations' do
      response.should be_instance_of Array
    end

    it 'returns the correct array' do
      response[-1].app.name.should == "GitHub API"
    end

    it 'returns a 404 if using access token authentication' do
      expect { test_client.authorizations }.to raise_error GitHub::NotFound
    end

    it 'returns a 404 if using no authentication' do
      expect { GitHub.authorizations }.to raise_error GitHub::NotFound
    end 
  end

  describe '.authorization', :vcr do
    let(:response) { test_basic_client.authorization(3410354) }

    it 'returns authorization information' do
      response.should be_instance_of Hash
    end

    it 'returns the correct information' do
      response.id.should == 3410354
    end

    it 'returns a 404 when not found' do
      expect { test_basic_client.authorization(341035423) }.to raise_error GitHub::NotFound
    end

    it 'returns a 404 if using access token authentication' do
      expect { test_client.authorization(341035423) }.to raise_error GitHub::NotFound
    end

    it 'returns a 404 if using no authentication' do
      expect { GitHub.authorization(341035423) }.to raise_error GitHub::NotFound
    end
  end

  authorization_id = ""
  describe '.create_authorization', :vcr do
    let(:response) { test_basic_client.create_authorization(:note => "Test authorization.", :client_id => test_client_id, :client_secret => test_client_secret) }
    
    it 'returns authorization information hash' do
      response.should be_instance_of Hash
      authorization_id = response.id
    end

    it 'creates the correct authorization' do
      response.app.client_id.should == test_client_id
    end
  end

  describe '.update_authorization', :vcr do
    let(:response) { test_basic_client.update_authorization(authorization_id, :note => "Updated test authorization.") } 

    it 'returns authorization information hash' do
      response.should be_instance_of Hash
    end

    it 'updates the authorization' do
      response.note.should == "Updated test authorization."
    end
  end

  describe '.delete authorization', :vcr do
    let(:response) { test_basic_client.delete_authorization(authorization_id) }

    it 'returns true' do
      response.should be_true
    end

    it 'deletes the authorization' do
      expect { test_basic_client.authorization(authorization_id) }.to raise_error GitHub::NotFound
    end
  end

end