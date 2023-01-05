# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    layout "devise"
    # GET /resource/password/new

    # POST /resource/password

    # GET /resource/password/edit?reset_password_token=abcdef

    # PUT /resource/password
    def update
      super do |user|
        @redirect_to_onboarding = true if user.encrypted_password_was
      end
    end

    # The path used after sending reset password instructions
    def after_resetting_password_path_for(resource)
      if Flipper.enabled?(:onboarding) && @redirect_to_onboarding
        onboarding_index_path
      else
        super
      end
    end
  end
end
