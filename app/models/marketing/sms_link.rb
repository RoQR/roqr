# frozen_string_literal: true

module Marketing
  class SmsLink
    include ActiveModel::API
    include ActiveModel::Serialization
    include ERB::Util
    attr_accessor :number, :body

    def type
      :sms_link
    end

    def attributes
      { "type" => :sms, "number" => nil, "body" => nil }
    end

    def save
      true
    end

    def barcode_data
      "sms:#{u number}?body=#{u body}"
    end
  end
end
