# frozen_string_literal: true

module Marketing
  class WifiLink
    include ActiveModel::API
    include ActiveModel::Serialization
    include ERB::Util
    attr_accessor :ssid, :password, :hidden, :protocol

    def type
      :wifi_link
    end

    def attributes
      { "type" => :wifi, "ssid" => nil, "password" => nil, "hidden" => false, "protocol" => "WPA" }
    end

    def save
      true
    end

    def barcode_data
      "WIFI:S:#{u ssid};T:#{u protocol};P:#{u password};H:#{u hidden};;"
    end
  end
end
