class EventsController < ApplicationController
  before_action :set_events, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end
end
