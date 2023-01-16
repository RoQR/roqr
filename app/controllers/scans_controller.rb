# frozen_string_literal: true

class ScansController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @all_scans = @scans.includes([:link])
    @links_stats = @all_scans.joins(:link).group("links.name").order("count_id desc").count("id")
    @platform_stats = @all_scans.group(:platform_name).order("count_id desc").count("id")
    @browser_stats = @all_scans.group(:browser_name).order("count_id desc").count("id")
    @countries_stats = @all_scans.group(:country).order("count_id desc").count("id")
    @paginated_scans = @all_scans.page params[:page]
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end
end
