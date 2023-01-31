# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout :resolve_layout
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up

    # POST /resource
    def create
      success = verify_recaptcha(action: "register", minimum_score: 0.5,
                                 secret_key: ENV.fetch("RECAPTCHA_V3_SECRET_KEY", nil))
      checkbox_success = verify_recaptcha unless success
      if success || checkbox_success
        super
      else
        @show_checkbox_recaptcha = true unless success
        build_resource sign_up_params
        clean_up_passwords resource
        flash.now[:alert] = "Recaptcha verification failed. Please try again"
        flash.delete :recaptcha_error
        render :new, status: :unprocessable_entity
      end
    end

    # GET /resource/edit

    # PUT /resource

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

    def update_resource(resource, params)
      resource.update(params)
    end

    # The path used after sign up.

    # The path used after sign up for inactive accounts.

    def resolve_layout
      case action_name
      when "update"
        "application"
      else
        "devise"
      end
    end
  end
end
