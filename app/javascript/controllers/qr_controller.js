import { Controller } from "@hotwired/stimulus"
import QRCodeStyling from "qr-code-styling"

export default class extends Controller {
  static values = { barcodeData: String, size: Number }
  static targets = [ "canvas", "fill", "color", "positionBorder", "positionCore", "image" ]
  
  connect() {
    this.qrCode = new QRCodeStyling(this.options());
    this.qrCode.append(this.canvasTarget);
  }

  update() {
    this.qrCode.update(this.options())
  }

  download() {
    this.qrCode.download(this.downloadOptions())
  }

  options() {
    let size = this.sizeValue || 300;
    return {
      data: this.barcodeDataValue,
      height: size,
      width: size,
      margin: 20,
      dotsOptions: {
        color: this.colorTarget.value,
        type: "rounded"
      },
      cornersSquareOptions: {
        color: this.positionBorderTarget.value
      },
      cornersDotOptions: {
        color: this.positionCoreTarget.value
      },
      backgroundOptions: {
        color: this.fillTarget.value
      }
    }
  }

  downloadOptions() {
    return {
      extension: 'png'
    }
  }
}
