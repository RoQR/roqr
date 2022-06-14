class EmailLink < ApplicationRecord
include LinkDataModelConcern
  include ERB::Util

  def summary
    email_address
  end

  def barcode_data
    "mailto:" + "#{u email_address}?subject=#{u subject}&body=#{u body}"
  end
end
