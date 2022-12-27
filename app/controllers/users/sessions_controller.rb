# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout "devise"
    before_action :configure_sign_in_params, only: [:create]
    skip_before_action :redirect_if_inactive_subscription

    # GET /resource/sign_in

    # POST /resource/sign_in

    # DELETE /resource/sign_out

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
  end
end
