# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  def new
    authorize! :invite, User
    super
  end

  def edit
    super
  end

  def create
    authorize! :invite, User
    super
  end

  def update
    super do |user|
      Notification.create(recipient: user.invited_by, actor: user, action: 'joined', notifiable: user)
    end
  end

  private

  def invite_resource
    super do |user|
      user.organization = current_user.organization
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite,
                                      keys: %i[name can_create_links can_edit_links can_delete_links can_edit_organization can_delete_organization
                                               can_invite_users can_edit_users can_delete_users organization_id])
  end
end
