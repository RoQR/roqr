class SmsLink < ApplicationRecord
  include LinkDataModelConcern
  include ERB::Util

  def summary
    number
  end

  def barcode_data
    "sms:" + "#{u number}?body=#{u body}"
  end
end
