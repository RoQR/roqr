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

  def empty_period(start_at, end_at = Date.today.end_of_day, step: :day, format: "%d %b")
    (start_at.to_i..end_at.to_i).step(1.send(step)).to_h do |t|
      [Time.at(t).strftime(format), 0]
    end
  end

  def timeline_stats
    case @period_filter
    when "all"
      if @organization.created_at > 1.month.ago
        @scans
          .group_by_day(:created_at, format: "%d %b")
          .count
          .reverse_merge(
            empty_period(
              @organization.created_at
            )
          )
      elsif @organization.created_at > 3.months.ago
        @scans
          .group_by_week(:created_at, format: "%d %b")
          .count
          .reverse_merge(
            empty_period(
              @organization.created_at,
              Time.now.end_of_week,
              step: :week
            )
          )
      else
        @scans
          .group_by_month(:created_at, format: "%b %Y")
          .count
          .reverse_merge(
            empty_period(
              @organization.created_at.beginning_of_month,
              Time.now.end_of_month,
              step: :month,
              format: "%b %Y"
            )
          )
      end

    when "30d"
      @scans.group_by_day(:created_at, format: "%d %b").count.reverse_merge(empty_period(30.days.ago))
    when "7d"
      @scans.group_by_day(:created_at, format: "%d %b").count.reverse_merge(empty_period(7.days.ago))
    when "today"
      @scans.group_by_hour(
        :created_at, format: "%l%p"
      ).count.reverse_merge(empty_period(Date.today.beginning_of_day, step: :hour, format: "%l%p"))
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
          min: 0,
          suggestedMax: 10,
          grid: {
            display: false, drawBorder: false
          }
        }
      }
    }
  end
end
