module GitHub
  class Client

    # Methods for the Orgs API.
    #
    # @see http://developer.github.com/v3/orgs/
    module Orgs

      # Get an organization.
      #
      # @param org [String] Organization name.
      # @return [Hash] Organization information.
      # @see http://developer.github.com/v3/orgs/#get-an-organization
      # @example
      #   GitHub.organization('github')
      def organization(org)
        get "/orgs/#{org}", auth_params
      end

      # Edit an organization.
      #
      # Requires authentication.
      # @param org [String] Organization name.
      # @param options [Hash] Optional parameters.
      # @option options [String] :billing_email Billing email address, is not publicized.
      # @option options [String] :company
      # @option options [String] :email Publicly visible email address
      # @option options [String] :location
      # @option options [String] :name
      # @return [Hash] Repository information.
      # @see http://developer.github.com/v3/orgs/#edit-an-organization
      # @example
      #   client.edit_organization('facebook',name:'faceeebooook',location:'California')
      def edit_organization(org, options={})
        patch "/orgs/#{org}", auth_params, options
      end
    end

  end
end