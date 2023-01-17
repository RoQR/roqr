# frozen_string_literal: true

class ScansController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_filters
  before_action :filter_scans

  def index
    @scans = @scans.includes([:link])
    @timeline_stats = timeline_stats
    @links_stats = @scans.group("links.name").order("count_id desc").count("id")
    @platform_stats = @scans.group(:platform_name).order("count_id desc").count("id")
    @browser_stats = @scans.group(:browser_name).order("count_id desc").count("id")
    @countries_stats = @scans.group(:country).order("count_id desc").count("id")
    @paginated_scans = @scans.page params[:page]
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end

  private

  def set_filters
    @period = params[:period] || "30d"
  end

  def filter_scans
    filter_by_period
  end

  def filter_by_period
    @scans = case @period
             when "all"
               @scans
             when "30d"
               @scans.last_thirty_days
             when "today"
               @scans.today
             end
  end

  def timeline_stats
    case @period
    when "all"
      @scans.group_by_day(:created_at, format: "%d %b").count
    when "30d"
      @scans.group_by_day(:created_at, format: "%d %b").count
    when "today"
      @scans.group_by_hour(:created_at, format: "%l%p").count
    end
  end
end
