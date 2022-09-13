import { Controller } from "@hotwired/stimulus"
import QRCodeStyling from "qr-code-styling"

export default class extends Controller {
  static values = { barcodeData: String }
  static targets = [ "canvas", "dotsColor", "backgroundColor", "cornerSquaresColor", "cornerDotsColor", "image" ]
  
  connect() {
    this.qrCode = new QRCodeStyling(this.options());
    this.qrCode.append(this.canvasTarget);
  }

  update() {
    this.qrCode.update(this.options())
  }

  download({ params }) {
    this.qrCode.download(params)
  }

  options() {
    let size = 500;
    return {
      data: this.barcodeDataValue,
      height: size,
      width: size,
      margin: 20,
      dotsOptions: {
        color: this.dotsColorTarget.value
      },
      cornersSquareOptions: {
        color: this.cornerSquaresColorTarget.value
      },
      cornersDotOptions: {
        color: this.cornerDotsColorTarget.value
      },
      backgroundOptions: {
        color: this.backgroundColorTarget.value
      }
    }
  }
}
