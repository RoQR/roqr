module LinksHelper
    def qr(url)
      RQRCode::QRCode.new(url)
    end

  def barcode_data(link)
    if link.dynamic?
      scan_link_url(link)
    else
      link.barcode_data
    end
  end
end
