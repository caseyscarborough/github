module GitHub
  class Client

    # Contains methods for the Markdown API.
    #
    # @see http://developer.github.com/v3/markdown/
    module Markdown

      # Render a markdown document.
      #
      # @param text [String] The Markdown text to render.
      # @param options [Hash] The optional options.
      # @option options [String] :mode The rendering mode.
      # @option options [String] :context The repository context, only used when in 'gfm' mode.
      # @return [String] The rendered text.
      # @see http://developer.github.com/v3/markdown/#render-an-arbitrary-markdown-document
      # @example
      #   GitHub.markdown('# Hello World! ## H2 **yeah**!')
      # @example
      #   GitHub.markdown('# GitHub', mode: 'gfm', context: 'caseyscarborough/github')
      def markdown(text, options={:mode => 'markdown'})
        options.merge!(:text => text)
        post "/markdown", :body => options
      end

    end

  end
end