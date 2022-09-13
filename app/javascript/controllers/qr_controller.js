import { Controller } from "@hotwired/stimulus"
import QRCodeStyling from "qr-code-styling"

export default class extends Controller {
  static values = { barcodeData: String }
  static targets = [ "canvas", "dotsColor", "backgroundColor", "cornerSquaresColor", "cornerDotsColor", "image" ]
  
  connect() {
    this.copyCornerSquares = (this.dotsColorTarget.value == this.cornerSquaresColorTarget.value)
    this.copyCornerDots = (this.dotsColorTarget.value == this.cornerDotsColorTarget.value)
    this.qrCode = new QRCodeStyling(this.options());
    this.qrCode.append(this.canvasTarget);
  }

  stopCopyingCornerSquares() {
    this.copyCornerSquares = false
  }

  stopCopyingCornerDots() {
    this.copyCornerDots = false
  }

  update() {
    if (this.copyCornerSquares) {
      this.cornerSquaresColorTarget.value = this.dotsColorTarget.value
    }
    if (this.copyCornerDots) {
      this.cornerDotsColorTarget.value = this.dotsColorTarget.value
    }
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
