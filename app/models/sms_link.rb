# frozen_string_literal: true

class SmsLink < LinkData
  self.table_name = 'sms_links'
  has_one :link
  include ERB::Util

  def summary
    number
  end

  def barcode_data
    "sms:#{u number}?body=#{u body}"
  end
end
