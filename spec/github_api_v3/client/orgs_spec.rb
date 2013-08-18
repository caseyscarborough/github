require 'spec_helper'

describe GitHub::Client::Orgs do

  describe '.organization', :vcr do
    it 'returns an organization' do
      GitHub.organization('github').should be_instance_of Hash
    end
  end

end