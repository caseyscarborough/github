require 'spec_helper'

describe GitHub::Client::Gitignore do

  describe '.gitignore_list', :vcr do
    it 'returns an array of templates' do
      GitHub.gitignore_list.should be_instance_of Array
    end
  end

  describe '.gitignore', :vcr do
    let(:template) { GitHub.gitignore("Ruby") }
    
    it 'returns a hash' do
      template.should be_instance_of Hash
    end

    it 'returns the correct template' do
      template.name.should == "Ruby"
    end
  end

end