class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /events or /events.json
  def index
  end
end
