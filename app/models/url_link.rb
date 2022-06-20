class UrlLink < LinkData
  self.table_name = 'url_links'
  include LinkDataModelConcern
  validates :url, presence: true

  def summary
    url
  end

  def barcode_data
    url
  end
end
