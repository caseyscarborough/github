require 'spec_helper'

describe GitHub::Client::Markdown do

  describe '.markdown', :vcr do
    it 'returns rendered markdown' do
      content = GitHub.markdown('# Test!')
      content.should eq("<h1>\n<a name=\"test\" class=\"anchor\" href=\"#test\"><span class=\"octicon octicon-link\"></span></a>Test!</h1>")
    end
  end

end