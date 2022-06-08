module QrServices
  class QrService
    def initialize(url)
      @qrcode = RQRCode::QRCode.new(url)
    end
  end
end
