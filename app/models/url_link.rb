# frozen_string_literal: true

class UrlLink < LinkData
  self.table_name = 'url_links'
  validates :url, presence: true
  has_one :link

  def summary
    url
  end

  def barcode_data
    url
  end
end
