class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /events or /events.json
  def index
    respond_to do |format|
      format.html
      format.csv { send_data @events.to_csv, filename: "roqr-events-#{Date.today}.csv" }
    end
  end
end
