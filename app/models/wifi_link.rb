# frozen_string_literal: true

class WifiLink < LinkData
  self.table_name = "wifi_links"
  has_one :link
  has_encrypted :ssid, :password, :protocol, migrating: true
  has_encrypted :hidden, migrating: true, type: :boolean
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
