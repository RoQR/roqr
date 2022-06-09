module LinksHelper
    def qr(url)
      RQRCode::QRCode.new(url)
    end
end
