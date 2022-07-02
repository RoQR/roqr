
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { barcodeData: String }
  static targets = [ "fill", "color", "positionBorder", "positionCore", "image" ]

  updateImage() {
    var fill = this.fillTarget
    var color = this.colorTarget
    var positionBorder = this.positionBorderTarget
    var positionCore = this.positionCoreTarget
    var image = this.imageTarget

    image.src = `/qr.svg?data=${encodeURIComponent(this.barcodeDataValue)}&fill=${encodeURIComponent(fill.value)}&color=${encodeURIComponent(color.value)}&position_border=${encodeURIComponent(positionBorder.value)}&position_core=${encodeURIComponent(positionCore.value)}`
  }
}
