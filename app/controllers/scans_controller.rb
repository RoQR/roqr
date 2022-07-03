class ScansController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end
end