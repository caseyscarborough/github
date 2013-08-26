module GitHub
  class Client

    module Octocat

      # Retrieve an Octocat with a message of your choice,
      # or one chosen by GitHub. :)
      #
      # @return [String]
      def octocat(text=nil)
        options = {}
        options[:s] = text if text
        get "/octocat", params: options
      end

    end

  end
end