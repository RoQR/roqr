# frozen_string_literal: true

class Scan < ApplicationRecord
  paginates_per 25
  belongs_to :link

  after_create_commit do
    broadcast_append_to "onboarding", link.id, target: "scans", partial: "onboarding/redirect"
  end

  scope :by_datetime, -> { order(created_at: :desc) }

  def self.today(**options)
    group_by_hour(:created_at, range: Time.zone.now.midnight..Time.zone.now, format: "%l%p", **options).count
  end

  def self.last_seven_days(**options)
    group_by_day(:created_at, last: 7, **options).count
  end

  def self.last_thirty_days(**options)
    group_by_day(:created_at, last: 30, format: "%d %b", **options).count
  end

  def self.month_to_date(**options)
    group_by_day(:created_at, range: Date.current.beginning_of_month..Date.current, format: "%d %b", **options).count
  end

  def self.last_month(**options)
    group_by_day(:created_at, range: Date.current.prev_month.beginning_of_month..Date.current.prev_month.end_of_month, format: "%d %b",
                              **options).count
  end

  def self.year_to_date(**options)
    group_by_month(:created_at, range: Date.current.beginning_of_year..Date.current, format: "%b", **options).count
  end

  def self.last_twelve_months(**options)
    group_by_month(:created_at, last: 12, format: "%b", **options).count
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w[created_at link browser_name browser_version device_name platform_name platform_version language city
                country]

      all.each do |scan|
        csv << [scan.created_at, scan.link.name, scan.browser_name, scan.browser_version, scan.device_name,
                scan.platform_name, scan.platform_version, scan.language, scan.city, scan.country]
      end
    end
  end
end
