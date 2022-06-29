class Scan < ApplicationRecord
  belongs_to :link

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
