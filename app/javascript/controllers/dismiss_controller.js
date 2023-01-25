import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  dismiss() {
    this.element.classList.add("hidden");
    this.element.destroy;
  }
}

