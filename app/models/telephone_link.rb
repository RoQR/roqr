class TelephoneLink < ApplicationRecord
  include LinkDataModelConcern
  include ERB::Util

  def summary
    number
  end

  def barcode_data
    "tel:#{u number}"
  end
end