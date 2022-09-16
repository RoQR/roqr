module LinksHelper
  def barcode_data(link)
    if link.dynamic?
      scan_link_url(id: link.url_id)
    else
      link.barcode_data
    end
  end
end
