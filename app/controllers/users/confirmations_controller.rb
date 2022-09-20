# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new

    # POST /resource/confirmation

    # GET /resource/confirmation?confirmation_token=abcdef

    protected

    # The path used after resending confirmation instructions.

    # The path used after confirmation.
    def after_confirmation_path_for(_resource_name, resource)
      token = resource.send(:set_reset_password_token)
      edit_password_path(resource, reset_password_token: token)
    end
  end
end
