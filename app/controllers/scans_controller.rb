class ScansController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_scans = Scan.accessible_by(current_ability).includes(:link)
    @scans = @all_scans.page params[:page]
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end
end
