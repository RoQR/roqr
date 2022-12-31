# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters
    def new
      authorize! :invite, User
      super
    end

    def create
      authorize! :invite, User
      super
    end

    def update
      super do |user|
        InvitedUserAcceptedNotification.with(user_name: user.name).deliver_later(user.invited_by)
      end
    end

    private

    def invite_resource
      super do |user|
        user.organization = current_user.organization
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :invite, keys: %i[name role organization_id]
      )
    end

    def after_invite_path_for(_invited, _invitee)
      settings_organization_path
    end
  end
end
