
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: String }
  static targets = [ "fill", "color", "image" ]

  updateImage() {
    var fill = this.fillTarget
    var color = this.colorTarget
    var image = this.imageTarget

    image.src = `/links/${this.idValue}.svg?fill=${encodeURIComponent(fill.value)}&color=${encodeURIComponent(color.value)}`
  }
}
