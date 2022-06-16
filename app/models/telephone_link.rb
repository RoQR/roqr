class TelephoneLink < ApplicationRecord
  include LinkDataModelConcern

  def summary
    number
  end

  def barcode_data
    "tel:#{number}"
  end
end
