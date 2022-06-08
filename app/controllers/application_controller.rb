class ApplicationController < ActionController::Base
  def current_user
    User.new
  end
end
