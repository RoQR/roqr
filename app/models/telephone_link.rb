# frozen_string_literal: true

class TelephoneLink < LinkData
  self.table_name = "telephone_links"
  has_one :link
  has_encrypted :number, migrating: true
  include ERB::Util

  def summary
    number
  end

  def barcode_data
    "tel:#{u number}"
  end
end
