# frozen_string_literal: true

class ScansController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_scans = Scan.accessible_by(current_ability)
    @scans = @all_scans.page params[:page]
    @links_stats = @all_scans.joins(:link).group('links.name').count
    @platform_stats = @all_scans.group(:platform_name).count
    @browser_stats = @all_scans.group(:browser_name).count
    @countries_stats = @all_scans.group(:country).count
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end
end
