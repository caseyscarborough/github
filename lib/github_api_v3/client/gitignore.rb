module GitHub
  class Client

    # Contains methods for the Gitignore API.
    #
    # @see http://developer.github.com/v3/gitignore/
    module Gitignore

      # Lists available .gitignore templates.
      #
      # @return [Array] List of template names.
      # @see http://developer.github.com/v3/gitignore/#listing-available-templates
      # @example
      #   GitHub.gitignore_list
      def gitignore_list
        get '/gitignore/templates'
      end

      # Gets a single .gitignore template.
      #
      # @param name [String] The template name.
      # @return [String] The template contents.
      # @see http://developer.github.com/v3/gitignore/#get-a-single-template
      # @example
      #   GitHub.gitignore("Ruby")
      def gitignore(name)
        get "/gitignore/templates/#{name}"
      end

    end

  end
end