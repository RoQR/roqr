# frozen_string_literal: true

module LinksHelper
  def barcode_data(link)
    if link.dynamic?
      scan_link_url(id: link.hashid)
    else
      link.barcode_data
    end
  end
end
