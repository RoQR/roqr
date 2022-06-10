class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warn

  def current_user
    User.new
  end
end
