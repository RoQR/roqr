class WifiLink < LinkData
  self.table_name = 'wifi_links'
  has_one :link
  include ERB::Util

  def summary
    ssid
  end

  def barcode_data
    "WIFI:S:#{u ssid};T:#{u protocol};P:#{u password};H:#{u hidden};;"
  end
end
