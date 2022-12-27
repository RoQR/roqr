# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    skip_before_action :redirect_if_inactive_subscription
    layout "devise"
    # GET /resource/password/new

    # POST /resource/password

    # GET /resource/password/edit?reset_password_token=abcdef

    # PUT /resource/password

    # The path used after sending reset password instructions
  end
end
