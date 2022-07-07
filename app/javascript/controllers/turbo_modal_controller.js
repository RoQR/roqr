import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition"

export default class extends Controller {
  static targets = ["backdrop", "body"]
  connect() {
    document.addEventListener('turbo:submit-end', this.submitEnd)
    enter(this.backdropTarget);
    enter(this.bodyTarget);
  }

  disconnect() {
    document.removeEventListener('turbo:submit-end', this.submitEnd)
  }

  hideModal() {
    event.preventDefault();
    leave(this.bodyTarget);
    leave(this.backdropTarget).then(() => {
        this.element.parentElement.removeAttribute("src");
        this.element.remove();
    })
  }

  submitEnd = (e) => {
    if (e.detail.success) {
      this.hideModal()
    }
  }
}
