class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warn
  before_action :set_paper_trail_whodunnit
end
