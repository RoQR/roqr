class UrlLink < ApplicationRecord
  include LinkDataModelConcern
  validates :url, presence: true

  def summary
    url
  end

  def barcode_data
    url
  end
end
