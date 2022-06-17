class Event < ApplicationRecord
  belongs_to :link

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w{created_at link ip browser_name browser_version bot_name device_name platform_name platform_version language city country}

      all.each do |event|
        csv << [
          event.created_at,
          event.link.name,
          event.ip.to_s,
          event.browser_name,
          event.browser_version,
          event.bot_name,
          event.device_name,
          event.platform_name,
          event.platform_version,
          event.language,
          event.city,
          event.country
        ]
      end
    end
  end
end
