class EmailLink < ApplicationRecord
  include ERB::Util
  has_many :links, as: :link_data, dependent: :destroy
  accepts_nested_attributes_for :links
  has_paper_trail

  def summary
    email_address
  end

  def barcode_data
    "mailto:" + "#{u email_address}?subject=#{u subject}&body=#{u body}"
  end
end
