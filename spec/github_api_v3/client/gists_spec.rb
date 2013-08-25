require 'spec_helper'

describe GitHub::Client::Gists do

  describe '.gists', :vcr do
    it 'returns an array of gists' do
      test_client.gists('caseyscarborough').should be_instance_of Array
    end

    it 'returns an array of gists for authenticated user' do
      test_client.gists.should be_instance_of Array
    end

    it 'returns public gists for unauthenticated user' do
      test_client.gists.should be_instance_of Array
    end
  end

  describe '.gist', :vcr do
    it 'returns gist information' do
      test_client.gist('f49d891101430f45b2c9').should be_instance_of Hash
    end

    it 'returns a 404 when not found' do
      expect { test_client.gist(9999999) }.to raise_error GitHub::NotFound
    end
  end

  gist_id = ""
  describe '.create_gist', :vcr do
    it 'creates a gist' do
      gist = test_client.create_gist(files: {"file1.txt" => { content: "File contents" }}, description: "Gist description", public: "false")
      gist.should be_instance_of Hash
      gist_id = gist.id
    end
  end

  describe '.edit_gist', :vcr do
    it 'edits a gist' do
      gist = test_client.edit_gist(gist_id, description: "Edited gist description")
      gist.description.should == "Edited gist description"
    end
  end

  describe '.delete_gist', :vcr do
    it 'deletes a gist' do
      test_client.delete_gist(gist_id).should be_true
    end
  end

  describe '.star_gist', :vcr do
    it 'stars a gist' do
      test_client.star_gist('f49d891101430f45b2c9').should be_true
    end

    it 'returns false when not found' do
      test_client.star_gist(9999999).should be_false
    end
  end

  describe '.gist_starred?', :vcr do
    it 'should return true or false' do
      [true,false].should include test_client.gist_starred?('f49d891101430f45b2c9')
    end

    it 'returns false when not found' do
      test_client.gist_starred?(9999999).should be_false
    end
  end

  describe '.unstar_gist', :vcr do
    it 'unstars a gist' do
      test_client.unstar_gist('f49d891101430f45b2c9').should be_true
    end

    it 'returns false when not found' do
      test_client.unstar_gist(9999999).should be_false
    end
  end

  describe '.fork_gist', :vcr do
    it 'forks a gist' do
      [true,false].should include test_client.fork_gist(1133830)
    end

    it 'returns false when not found' do
      test_client.fork_gist(9999999).should be_false
    end
  end

  describe '.gist_comments', :vcr do
    it 'returns a list of comments' do
      test_client.gist_comments('f49d891101430f45b2c9').should be_instance_of Array
    end

    it 'returns a 404 when not found' do
      expect { test_client.gist_comments(9999999) }.to raise_error GitHub::NotFound
    end
  end

  comment_id = ""
  describe '.create_gist_comment', :vcr do
    it 'returns comment information after creation' do
      comment = test_client.create_gist_comment('f49d891101430f45b2c9', 'Awesome!')
      comment_id = comment.id
      comment.should be_instance_of Hash
    end

    it 'creates the comment' do
      test_client.gist_comment('f49d891101430f45b2c9', comment_id).should be_instance_of Hash
    end
  end

  describe '.gist_comment', :vcr do
    it 'returns a comment' do
      test_client.gist_comment('f49d891101430f45b2c9', comment_id).should be_instance_of Hash
    end

    it 'returns a 404 when not found' do
      expect { test_client.gist_comment('f49d891101430f45b2c9', 1234) }.to raise_error GitHub::NotFound
    end
  end

  describe '.edit_gist_comment', :vcr do
    it 'returns comment information after editing' do
      test_client.edit_gist_comment('f49d891101430f45b2c9', comment_id, 'Even more awesome!').should be_instance_of Hash
    end

    it 'edits the comment' do
      test_client.gist_comment('f49d891101430f45b2c9', comment_id).body == 'Even more awesome!'
    end
  end

  describe '.delete_gist_comment', :vcr do
    it 'returns true or false' do
      [true,false].should include test_client.delete_gist_comment('f49d891101430f45b2c9', comment_id)
    end

    it 'deletes the comment' do
      expect { test_client.gist_comment('f49d891101430f45b2c9', comment_id) }.to raise_error GitHub::NotFound
    end
  end











end