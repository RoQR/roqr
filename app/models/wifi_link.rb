class WifiLink < LinkData
  self.table_name = 'wifi_links'
  has_one :link

  def summary
    ssid
  end

  def barcode_data
    "WIFI:S:#{ssid};T:#{protocol};P:#{password};H:#{hidden};;"
  end
end
