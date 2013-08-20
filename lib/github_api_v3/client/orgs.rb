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
      #
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

      # List all users who are members of an organization.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of members.
      # @see http://developer.github.com/v3/orgs/members/#members-list
      def organization_members(org)
        get "/orgs/#{org}/members", auth_params
      end

      # Check if a user is, publicly or privately, a member of the organization.
      #
      # @param org [String] Organization name.
      # @param username [String] User to check for.
      # @return [Boolean] True if user is a member, false if not.
      # @see http://developer.github.com/v3/orgs/members/#check-membership
      def organization_member?(org, username)
        boolean_get "/orgs/#{org}/members/#{username}", auth_params
      end

      # Retrieve public members of an organization.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of members.
      # @see http://developer.github.com/v3/orgs/members/#public-members-list
      def organization_public_members(org)
        get "/orgs/#{org}/public_members", auth_params
      end

      # Check if a user is publicly a member of the organization.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of members.
      # @see http://developer.github.com/v3/orgs/members/#check-public-membership
      def organization_public_member?(org, username)
        boolean_get "/orgs/#{org}/public_members/#{username}", auth_params
      end

      # Make a user's organization membership public.
      #
      # Requires authentication.
      #
      # @param org [String] Organization name.
      # @param username [String] Username of user to publicize.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/members/#publicize-a-users-membership
      def publicize_membership(org, username)
        boolean_put "/orgs/#{org}/public_members/#{username}", auth_params
      end

      # Conceal a user's organization membership.
      #
      # Requires authentication.
      #
      # @param org [String] Organization name.
      # @param username [String] Username of user to publicize.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/members/#conceal-a-users-membership
      def unpublicize_membership(org, username)
        boolean_delete "/orgs/#{org}/public_members/#{username}", auth_params
      end

    end

  end
end