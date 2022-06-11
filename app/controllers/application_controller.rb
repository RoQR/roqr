class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warn

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
