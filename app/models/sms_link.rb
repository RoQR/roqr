# frozen_string_literal: true

class SmsLink < LinkData
  self.table_name = "sms_links"
  has_one :link
  has_encrypted :number, :body
  self.ignored_columns = %w[number body]
  include ERB::Util

  def summary
    number
  end

  def barcode_data
    "sms:#{u number}?body=#{u body}"
  end
end
