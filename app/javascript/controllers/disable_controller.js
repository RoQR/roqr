import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'item' ]

  toggle() {
    this.itemTargets.forEach(item => {
      if (item.disabled) {
        item.disabled = false
      } else {
        item.disabled = true
      }
    })
  }

  enable() {
    this.itemTargets.forEach(item => {
      item.disabled = false
    })
  }

  disable() {
    this.itemTargets.forEach(item => {
      item.disabled = true
    })
  }
}

