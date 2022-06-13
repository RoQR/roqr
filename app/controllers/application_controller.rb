class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :warn
  before_action :set_paper_trail_whodunnit

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: 'layouts/empty', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end
end
