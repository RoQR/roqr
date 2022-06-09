module Linkable
  extend ActiveSupport::Concern

  included do
    def qr
      RQRCode::QRCode.new(self.url)
    end
  end
end
