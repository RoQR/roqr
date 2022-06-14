class EmailLink < ApplicationRecord
  has_many :links, as: :link_data, dependent: :destroy
  accepts_nested_attributes_for :links
  has_paper_trail

  def summary
    email_address
  end

  def barcode_data
    query_data = {subject: subject, body: body}.to_query
    "mailto:#{email_address}?#{query_data}"
  end
end
