# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  add_flash_types :info, :error, :success, :warn
  before_action :set_paper_trail_whodunnit

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
      format.html { render template: 'errors/not_found_error', layout: 'layouts/empty', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end
