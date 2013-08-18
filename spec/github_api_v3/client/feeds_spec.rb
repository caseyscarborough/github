require 'spec_helper'

describe GitHub::Client::Feeds do

  describe '.feeds', :vcr do
    it 'returns feed information' do
      feed = test_client.feeds
      feed.should be_instance_of Hash
    end
  end

end