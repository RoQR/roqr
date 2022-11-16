import { Controller } from "@hotwired/stimulus"
import QRCodeStyling from "qr-code-styling"

export default class extends Controller {
  static values = { barcodeData: String }
  static targets = [ "canvas", "dotsColor", "dotsShape", "transparentBackground", "backgroundColor", "copyCornerSquares", "cornerSquaresColor", "cornerSquaresShape", "copyCornerDots", "cornerDotsColor", "cornerDotsShape", "imageUrl" ]
  
  connect() {
    this.qrCode = new QRCodeStyling(this.options());
    this.qrCode.append(this.canvasTarget);
  }

  update() {
    if (this.copyCornerSquaresTarget.checked) {
      this.cornerSquaresColorTarget.value = this.dotsColorTarget.value;
      this.cornerSquaresShapeTarget.value = '';
    }
    if (this.copyCornerDotsTarget.checked) {
      this.cornerDotsColorTarget.value = this.dotsColorTarget.value
      this.cornerDotsShapeTarget.value = '';
    }
    this.qrCode.update(this.options())
  }

  download({ params }) {
    this.qrCode.download(params)
  }

  options() {
    let size = 500;
    if ((this.transparentBackgroundTarget.type == 'hidden' && this.transparentBackgroundTarget.value == 'true') ||
      (this.transparentBackgroundTarget.type == 'checkbox' && this.transparentBackgroundTarget.checked)) {
      this.backgroundColor = 'transparent';
    } else {
      this.backgroundColor = this.backgroundColorTarget.value;
    }
    return {
      data: decodeURIComponent(this.barcodeDataValue),
      height: size,
      width: size,
      margin: 20,
      image: this.imageUrlTarget.value,
      dotsOptions: {
        color: this.dotsColorTarget.value,
        type: this.dotsShapeTarget.value
      },
      cornersSquareOptions: {
        color: this.cornerSquaresColorTarget.value,
        type: this.cornerSquaresShapeTarget.value
      },
      cornersDotOptions: {
        color: this.cornerDotsColorTarget.value,
        type: this.cornerDotsShapeTarget.value
      },
      backgroundOptions: {
        color: this.backgroundColor
      },
      imageOptions: {
        margin: 10
      }
    }
  }
}
