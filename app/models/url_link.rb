class UrlLink < ApplicationRecord
  validates :url, presence: true
  has_many :links, as: :link_data, dependent: :destroy
  accepts_nested_attributes_for :links
  has_paper_trail

  def summary
    url
  end

  def barcode_data
    url
  end
end
