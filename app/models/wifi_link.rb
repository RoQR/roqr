# frozen_string_literal: true

class WifiLink < LinkData
  self.table_name = "wifi_links"
  has_one :link
  has_encrypted :ssid, :password, :protocol
  has_encrypted :hidden, type: :boolean
  self.ignored_columns = %w[ssid password protocol hidden]
  include ERB::Util

  def summary
    ssid
  end

  def barcode_data
    "WIFI:S:#{u ssid};T:#{u protocol};P:#{u password};H:#{u hidden};;"
  end

  def self.static_only?
    true
  end
end
