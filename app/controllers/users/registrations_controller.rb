# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout "devise"
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up

    # POST /resource

    # GET /resource/edit

    # PUT /resource
    #
    # DELETE /resource
    def destroy
      super do |user|
        user.organization.destroy
      end
    end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[attribute name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute name])
    end

    # The path used after sign up.

    # The path used after sign up for inactive accounts.
  end
end
