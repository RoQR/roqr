# frozen_string_literal: true

class ScansController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_filters
  before_action :filter_scans

  def index
    @scans = @scans.includes(:link)
    set_chart_data
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
    @link = params[:link]
    @platform = params[:platform]
    @browser = params[:browser]
    @country = params[:country]
  end

  def filter_scans
    filter_by_period
    filter_by_link
    filter_by_platform
    filter_by_browser
    filter_by_country
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

  def filter_by_link
    return unless params["link"]

    @scans = @scans.includes(:link).where(links: { name: params["link"] })
  end

  def filter_by_platform
    return unless @platform

    @scans = @scans.where(platform_name: @platform)
  end

  def filter_by_browser
    return unless @browser

    @scans = @scans.where(browser_name: @browser)
  end

  def filter_by_country
    return unless @country

    @scans = @scans.where(country: @country)
  end

  def empty_period(start)
    (start.to_i..Date.today.end_of_day.to_i).step(1.day).map do |t|
      [Time.at(t).strftime("%d %b"), 0]
    end.to_h
  end

  def empty_day
    (Date.today.beginning_of_day.to_i..Date.today.end_of_day.to_i).step(1.hour).map do |t|
      [Time.at(t).strftime("%l%p"), 0]
    end.to_h
  end

  def timeline_stats
    case @period
    when "all"
      @scans.group_by_day(:created_at, format: "%d %b").count.reverse_merge(empty_period(@scans.first.created_at))
    when "30d"
      @scans.group_by_day(:created_at, format: "%d %b").count.reverse_merge(empty_period(30.days.ago))
    when "today"
      @scans.group_by_hour(:created_at, format: "%l%p").count.reverse_merge(empty_day)
    end
  end

  def set_chart_data
    @timeline_stats = timeline_stats
    @chart_data = {
      labels: @timeline_stats.keys,
      datasets: [{
        pointStyle: false,
        fill: "origin",
        borderColor: "#facc15",
        borderWidth: 1,
        backgroundColor: "#9d862a",
        tension: 0.1,
        data: @timeline_stats.values
      }]
    }
    @chart_options = {
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          grid: {
            display: false, drawBorder: false
          }
        }
      }
    }
  end
end
