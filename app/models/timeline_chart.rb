# frozen_string_literal: true

class TimelineChart
  FORMATS = {
    hourly: "%l%p",
    daily: "%d %b",
    weekly: "%d %b",
    monthly: "%b %Y"
  }.freeze

  CHART_OPTIONS = {
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
  }.freeze

  def initialize(data, period)
    @data = data
    @period = period
  end

  def chart_data
    {
      labels: internal_chart_data&.keys,
      datasets: [{
        pointStyle: false,
        fill: "origin",
        borderColor: "#facc15",
        borderWidth: 1,
        backgroundColor: "#9d862a",
        tension: 0.1,
        data: internal_chart_data&.values
      }]
    }
  end

  def chart_options
    CHART_OPTIONS
  end

  private

  def internal_chart_data
    return nil if @data.nil?

    case @period
    when "all"
      alltime_chart_data
    when "30d"
      aggregate_data(@data, :daily, 30.days.ago)
    when "7d"
      aggregate_data(@data, :daily, 7.days.ago)
    when "today"
      aggregate_data(@data, :hourly, Date.today.beginning_of_day)
    end
  end

  def alltime_chart_data
    if first_date > 1.month.ago
      aggregate_data(@data, :daily, first_date)
    elsif first_date > 3.months.ago
      aggregate_data(@data, :weekly, first_date)
    else
      aggregate_data(@data, :monthly, first_date)
    end
  end

  def first_date
    @first_date ||= @data.map(&:created_at).min
  end

  def end_at(periodicity)
    case periodicity
    when :hourly, :daily
      Date.today.end_of_day
    when :weekly
      Time.now.end_of_week
    when :monthly
      Time.now.end_of_month
    end
  end

  def group_data(data, periodicity, format)
    case periodicity
    when :hourly
      data.group_by_hour(:created_at, format:)
    when :daily
      data.group_by_day(:created_at, format:)
    when :weekly
      data.group_by_week(:created_at, format:)
    when :monthly
      data.group_by_month(:created_at, format:)
    end
  end

  def step(periodicity)
    case periodicity
    when :hourly
      1.hour
    when :daily
      1.day
    when :weekly
      1.week
    when :monthly
      1.month
    end
  end

  def aggregate_data(data, periodicity, start_at)
    format = FORMATS[periodicity]
    end_at = end_at(periodicity)
    grouped = group_data(data, periodicity, format)
    grouped.count.reverse_merge(
      empty_period(start_at, end_at, step: step(periodicity), format:)
    )
  end

  def empty_period(start_at, end_at = Date.today.end_of_day, step: 1.day, format: "%d %b")
    (start_at.to_i..end_at.to_i).step(step).to_h do |t|
      [Time.at(t).strftime(format), 0]
    end
  end
end
