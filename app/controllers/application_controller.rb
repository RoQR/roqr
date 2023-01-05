# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :redirect_if_inactive_subscription, unless: :devise_controller?
  before_action :redirect_if_not_onboarded, unless: :devise_controller?
  include ApplicationHelper
  add_flash_types :info, :error, :success, :warn

  def devise_current_user
    @devise_current_user ||= warden.authenticate(scope: :user)
  end

  def token_current_user
    authenticate_with_http_token do |token, _options|
      @token_current_user ||= User.find_by(private_api_key: token)
    end
  end

  def current_user
    devise_current_user || token_current_user
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: "errors/not_found_error", layout: "layouts/empty", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render text: "internal error", status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  end

  def do_not_track?
    request.headers["DNT"] == "1"
  end

  def redirect_if_inactive_subscription
    return unless current_user

    redirect_to new_subscription_path unless current_user.organization.on_trial_or_subscribed?
  end

  def redirect_if_not_onboarded
    return unless current_user

    redirect_to onboarding_index_path unless current_user.terms_accepted
  end
end
