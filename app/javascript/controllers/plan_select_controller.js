
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { planId: Number }
  static classes = ["active"]

  select(e) {
    let target = e.target
    target.parentElement.classList.toggle(...this.activeClasses)
    this.planIdValue = target.value
  }
}

