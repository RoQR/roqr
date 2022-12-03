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
      this.cornerSquaresShapeTargets.forEach((el, i) => {
        el.checked = (el.value == '');
      });
      this.cornerSquaresShapeTarget.value = '';
    }
    if (this.copyCornerDotsTarget.checked) {
      this.cornerDotsColorTarget.value = this.dotsColorTarget.value
      this.cornerDotsShapeTargets.forEach((el, i) => {
        el.checked = (el.value == '');
      });
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
        type:  this.dotsShape()
      },
      cornersSquareOptions: {
        color: this.cornerSquaresColorTarget.value,
        type: this.cornerSquaresShape()
      },
      cornersDotOptions: {
        color: this.cornerDotsColorTarget.value,
        type: this.cornerDotsShape()
      },
      backgroundOptions: {
        color: this.backgroundColor
      },
      imageOptions: {
        margin: 10
      }
    }
  }

  dotsShape() {
    if (this.dotsShapeTargets.length > 1) {
      return this.dotsShapeTargets.find(x => x.checked).value;
    } else {
      return this.dotsShapeTarget.value;
    }
  }

  cornerSquaresShape() {
    if (this.cornerSquaresShapeTargets.length > 1) {
      return this.cornerSquaresShapeTargets.find(x => x.checked).value;
    } else {
      return this.cornerSquaresShapeTarget.value;
    }
  }

  cornerDotsShape() {
    if (this.cornerDotsShapeTargets.length > 1) {
      return this.cornerDotsShapeTargets.find(x => x.checked).value;
    } else {
      return this.cornerDotsShapeTarget.value;
    }
  }
}
