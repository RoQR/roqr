import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  dismiss() {
    this.itemTarget.classList.add("hidden");
    this.itemTarget.destroy;
  }
}

