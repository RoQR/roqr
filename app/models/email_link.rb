# frozen_string_literal: true

class EmailLink < LinkData
  self.table_name = "email_links"
  has_one :link
  encrypts :email_address, :subject, :body
  include ERB::Util

  def summary
    email_address
  end

  def barcode_data
    "mailto:#{u email_address}?subject=#{u subject}&body=#{u body}"
  end
end
