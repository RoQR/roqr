# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    skip_before_action :redirect_if_inactive_subscription
    # GET /resource/confirmation/new

    # POST /resource/confirmation

    # GET /resource/confirmation?confirmation_token=abcdef

    protected

    # The path used after resending confirmation instructions.

    # The path used after confirmation.
    def after_confirmation_path_for(_resource_name, resource)
      if resource.encrypted_password.present?
        root_path
      else
        token = resource.send(:set_reset_password_token)
        edit_password_path(resource, reset_password_token: token)
      end
    end
  end
end
