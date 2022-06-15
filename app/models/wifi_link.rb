class WifiLink < ApplicationRecord
  include LinkDataModelConcern

  def summary
    ssid
  end

  def barcode_data
    "WIFI:S:#{ssid};T:#{protocol};P:#{password};H:#{hidden};;"
  end
end
