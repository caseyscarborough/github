require 'base64'

module GitHub
  class Client

    # Methods for the Contents API.
    #
    # These methods allow the retrieval of contents of files within
    # a repository as Base64 encoded content.
    #
    # @see http://developer.github.com/v3/repos/contents/
    module Contents

      # Get the README of a repository.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param ref [String] The string name of the Commit/Branch/Tag, defaults to master.
      # @return [Hash] README information.
      # @see http://developer.github.com/v3/repos/contents/#get-the-readme
      def readme(owner, repo, ref='master')
        get "/repos/#{owner}/#{repo}/readme", :params => { :ref => ref }
      end

      # Get the contents of a file or directory.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param path [String] The path of the file or folder, defaults to the root of the repository.
      # @param ref [String] The string name of the Commit/Branch/Tag, defaults to master.
      # @return [Array, Hash] An array of files if path is a folder, or a hash of file information if a file, symlink, or submodule is specified.
      # @see http://developer.github.com/v3/repos/contents/#get-contents
      def contents(owner, repo, path='', ref='master')
        get "/repos/#{owner}/#{repo}/contents/#{path}", :params => { :ref => ref }
      end

      # Create a file in a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] File creation parameters.
      # @option options [String] :path (required) The file path.
      # @option options [String] :message (required) The commit message.
      # @option options [String] :content (required) The new file content.
      # @option options [String] :branch The branch name, defaults to master.
      # @option options [Hash] :committer The committer's information. If not present, the authenticated user's information is used. It should contain the committer's name and email, shown in the example.
      # @return [Hash] File content information.
      # @see http://developer.github.com/v3/repos/contents/#create-a-file
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.create_file(
      #     'caseyscarborough',
      #     'github',
      #     :path      => 'lib/new_file.txt',
      #     :message   => 'Add lib/new_file.txt.',
      #     :content   => 'This is a test file.',
      #     :committer => { :name => 'Casey Scarborough', :email => 'casey@example.com' }
      #   )
      def create_file(owner, repo, options={})
        options[:content] = Base64.strict_encode64(options[:content])
        put "/repos/#{owner}/#{repo}/contents/#{options[:path]}", :body => options
      end

      # Update a file in a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] File update parameters.
      # @option options [String] :path (required) The file path.
      # @option options [String] :message (required) The commit message.
      # @option options [String] :content (required) The new file content.
      # @option options [String] :sha (required) The blob SHA of the file being replaced.
      # @option options [String] :branch The branch name, defaults to default branch (usually master).
      # @option options [Hash] :committer The committer's information. If not present, the authenticated user's information is used. It should contain the committer's name and email, shown in the example.
      # @return [Hash] File content information.
      # @see http://developer.github.com/v3/repos/contents/#update-a-file
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.update_file(
      #     'caseyscarborough',
      #     'github',
      #     :path      => 'lib/update_file.txt',
      #     :message   => 'Update lib/update_file.txt.',
      #     :content   => 'This is a test file.',
      #     :sha       => '329688480d39049927147c162b9d2deaf885005f',
      #     :committer => { :name => 'Casey Scarborough', :email => 'casey@example.com' }
      #   )
      def update_file(owner, repo, options={})
        options[:content] = Base64.strict_encode64(options[:content])
        put "/repos/#{owner}/#{repo}/contents/#{options[:path]}", :body => options
      end
      alias :edit_file :update_file

      # Delete a file in a repository.
      #
      # Requires authentication.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param options [Hash] File deletion parameters.
      # @option options [String] :path (required) The path of the file to delete.
      # @option options [String] :content (required) The new file content.
      # @option options [String] :sha (required) The blob SHA of the file being deleted.
      # @option options [String] :branch The branch name, defaults to master.
      # @option options [Hash] :committer The committer's information. If not present, the authenticated user's information is used. It should contain the committer's name and email, shown in the example.
      # @return [Hash] File content information.
      # @see http://developer.github.com/v3/repos/contents/#update-a-file
      # @example
      #   client = GitHub.client(:login => 'caseyscarborough', :access_token => '7a329f6057f13c496ecf7fd777ceb9e79ae285')
      #   client.delete_file(
      #     'caseyscarborough',
      #     'github',
      #     :path      => 'lib/delete_me.txt',
      #     :message   => 'Delete lib/delete_me.txt.',
      #     :sha       => '329688480d39049927147c162b9d2deaf885005f',
      #     :committer => { :name => 'Casey Scarborough', :email => 'casey@example.com' }
      #   )
      def delete_file(owner, repo, options={})
        delete "/repos/#{owner}/#{repo}/contents/#{options[:path]}", :body => options
      end
      alias :remove_file :delete_file

      # Retrieve archive link.
      #
      # @param owner [String] The repository owner.
      # @param repo [String] The repository name.
      # @param format [String] Archive type. zipball (default) or tarball.
      # @param ref [String] Valid Git reference, defaults to master.
      # @return [String] Archive link.
      # @see http://developer.github.com/v3/repos/contents/#get-archive-link
      # @example Retrieve download link.
      #   GitHub.archive('caseyscarborough', 'github', 'tarball')
      #   # => "https://codeload.github.com/caseyscarborough/github/legacy.tar.gz/master"
      def archive(owner, repo, format='zipball', ref='master')
        request :get, "/repos/#{owner}/#{repo}/#{format}/#{ref}", :no_follow => true
      rescue HTTParty::RedirectionTooDeep => e
        e.response['location']
      end
    end

  end
end