# frozen_string_literal: true

class Scan < ApplicationRecord
  paginates_per 25
  belongs_to :link

  after_create_commit do
    broadcast_append_to "onboarding", link.id, target: "scans", partial: "onboarding/redirect"
  end

  scope :by_datetime, -> { order(created_at: :desc) }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :last_thirty_days, -> { where(created_at: 30.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :by_link_name, -> { joins(:link).group("links.name").count }

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
