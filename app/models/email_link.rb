# frozen_string_literal: true

class EmailLink < LinkData
  self.table_name = "email_links"
  has_one :link
  has_encrypted :email_address, :subject, :body
  self.ignored_columns = %w[email_address subject body]
  include ERB::Util

  def summary
    email_address
  end

  def barcode_data
    "mailto:#{u email_address}?subject=#{u subject}&body=#{u body}"
  end
end
