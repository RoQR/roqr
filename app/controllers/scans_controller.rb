# frozen_string_literal: true

class ScansController < ApplicationController
  include ScansHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_filters
  before_action :filter_scans

  def index
    @organization = current_user.organization
    @scans = @scans.includes(:link)
    set_chart_data

    @paginated_scans = @scans.page params[:page]
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv, filename: "roqr-scans-#{Date.today}.csv" }
    end
  end

  private

  def set_filters
    @period_filter = params[:period_filter] || "30d"
    @link_filter = params[:link_filter]
    @platform_filter = params[:platform_filter]
    @browser_filter = params[:browser_filter]
    @country_filter = params[:country_filter]
  end

  def filter_scans
    filter_by_period
    filter_by_link
    filter_by_platform
    filter_by_browser
    filter_by_country
  end

  def filter_by_period
    @scans = case @period_filter
             when "all"
               @scans
             when "7d"
               @scans.last_x_days(7)
             when "30d"
               @scans.last_x_days(30)
             when "today"
               @scans.today
             end
  end

  def filter_by_link
    return unless @link_filter

    @scans = @scans.includes(:link).where(links: { name: @link_filter })
  end

  def filter_by_platform
    return unless @platform_filter

    @scans = @scans.where(platform_name: @platform_filter)
  end

  def filter_by_browser
    return unless @browser_filter

    @scans = @scans.where(browser_name: @browser_filter)
  end

  def filter_by_country
    return unless @country_filter

    @scans = @scans.where(country: @country_filter)
  end

  def set_chart_data
    timeline_chart = TimelineChart.new(@scans, @period_filter)
    @chart_data = timeline_chart.chart_data
    @chart_options = timeline_chart.chart_options
  end
end
