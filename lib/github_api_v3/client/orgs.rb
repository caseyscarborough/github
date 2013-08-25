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

      # Remove member from an organization.
      #
      # Requires authentication.
      #
      # @param org [String] Organization name.
      # @param username [String] User to check for.
      # @return [Boolean] True if user is a member, false if not.
      # @see http://developer.github.com/v3/orgs/members/#remove-a-member
      def remove_organization_member(org, username)
        boolean_delete "/orgs/#{org}/members/#{username}", auth_params
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

      # List an organizations teams.
      #
      # Requires authentication.
      #
      # @param org [String] Organization name.
      # @return [Array] Array of teams.
      # @see http://developer.github.com/v3/orgs/teams/#list-teams
      def teams(org)
        get "/orgs/#{org}/teams", auth_params
      end

      # Get a team by its ID.
      #
      # Requires authentication.
      #
      # @param id [Integer] The ID of the team to get.
      # @return [Hash] Team information.
      # @see http://developer.github.com/v3/orgs/teams/#get-team
      def team(id)
        get "/teams/#{id}", auth_params
      end

      # Create a team for an organization.
      #
      # Requires authentication. The authenticated user must also be
      # an owner of the specified organization.
      #
      # @param org [String] Organization name.
      # @param team_name [String] The name of the new team.
      # @param options [Hash] Optional parameters.
      # @option options [String] :name (required)
      # @option options [Array] :repo_names Array of repo names as strings.
      # @option options [String] :permission pull (default), push, or admin.
      # @return [Hash] Team information.
      # @see http://developer.github.com/v3/orgs/teams/#create-team
      def create_team(org, team_name, options={})
        options.merge!(name: team_name)
        post "/orgs/#{org}/teams", auth_params, options
      end

      # Edit a team.
      #
      # Requires authentication. In order to edit a team, the authenticated
      # user must be an owner of the specified organization.
      #
      # @param id [Integer] The ID of the team.
      # @param team_name [String] The (new) name of the team.
      # @param options [Hash] Optional parameters.
      # @option options [String] :permission (see create_team)
      # @return [Hash] Team information.
      # @see http://developer.github.com/v3/orgs/teams/#edit-team
      def edit_team(id, team_name, options={})
        options.merge!(name: team_name)
        patch "/teams/#{id}", auth_params, options
      end

      # Delete a team.
      #
      # Requires authentication. In order to delete a team, the authenticated 
      # user must be an owner of the org that the team is associated with.
      #
      # @param id [Integer] The ID of the team.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#delete-team
      def delete_team(id)
        boolean_delete "/teams/#{id}", auth_params
      end

      # List team members
      #
      # Requires authentication. In order to list members in a team, the 
      # authenticated user must be a member of the team.
      #
      # @param id [Integer] The ID of the team.
      # @return [Array] Array of members.
      # @see http://developer.github.com/v3/orgs/teams/#list-team-members
      def team_members(id)
        get "/teams/#{id}/members", auth_params
      end

      # Determine if a user is a team member.
      #
      # Requires authentication. 
      # The authenticated user must be a member of the team.
      #
      # @param id [Integer] The ID of the team.
      # @param username [String] The username of the user to check for.
      # @return [Boolean] True if member, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#get-team-member
      def team_member?(id, username)
        boolean_get "/teams/#{id}/members/#{username}", auth_params
      end

      # Add a member to a team.
      #
      # Requires authentication. The authenticated user must have ‘admin’ 
      # permissions to the team or be an owner of the org that the team 
      # is associated with.
      #
      # @param id [Integer] The ID of the team.
      # @param username [String] The username of the user to add.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#add-team-member
      def add_team_member(id, username)
        boolean_put "/teams/#{id}/members/#{username}", auth_params
      end
      alias :add_organization_member :add_team_member

      # Remove a team member.
      #
      # Requires authentication. The authenticated user must have ‘admin’ 
      # permissions to the team or be an owner of the org that the team 
      # is associated with.
      # @param id [Integer] The ID of the team.
      # @param username [String] The username of the user to remove.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#remove-team-member
      def remove_team_member(id, username)
        boolean_delete "/teams/#{id}/members/#{username}", auth_params
      end

      # List all repositories for a team.
      #
      # Requires authentication.
      #
      # @param id [Integer] The ID of the team.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#list-team-repos
      def team_repos(id)
        get "/teams/#{id}/repos", auth_params
      end

      # Determine if a repo is managed by a team.
      #
      # Requires authentication.
      #
      # @param id [Integer] The ID of the team.
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @return [Boolean] True if it is managed by the team, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#get-team-repo
      def team_repo?(id, owner, repo)
        boolean_get "/teams/#{id}/repos/#{owner}/#{repo}", auth_params
      end

      # Add a team repository.
      #
      # Requires authentication. The authenticated user must be an owner 
      # of the org that the team is associated with. Also, the repo must 
      # be owned by the organization, or a direct fork of a repo owned 
      # by the organization.
      #
      # @param id [Integer] The ID of the team.
      # @param org [String] The organization to add the team for.
      # @param repo [String] The repository name.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#add-team-repo
      def add_team_repo(id, org, repo)
        boolean_put "/teams/#{id}/repos/#{org}/#{repo}", auth_params
      end

      # Remove a team repository.
      #
      # Requires authentication. The authenticated user must be an owner 
      # of the org that the team is associated with. NOTE: This does not 
      # delete the repo, it just removes it from the team.
      # @param id [Integer] The ID of the team.
      # @param owner [String] The repository owner's username.
      # @param repo [String] The repository name.
      # @return [Boolean] True if successful, false if not.
      # @see http://developer.github.com/v3/orgs/teams/#remove-team-repo
      def remove_team_repo(id, owner, repo)
        boolean_delete "/teams/#{id}/repos/#{owner}/#{repo}", auth_params
      end

    end

  end
end