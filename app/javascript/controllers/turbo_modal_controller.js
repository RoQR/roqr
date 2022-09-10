import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition"
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ["backdrop", "body"]
  connect() {
    document.addEventListener('turbo:submit-end', this.handleSubmit)
    useClickOutside(this, { element: this.bodyTarget });
    enter(this.backdropTarget);
    enter(this.bodyTarget);
  }

  disconnect() {
    document.removeEventListener('turbo:submit-end', this.handleSubmit)
  }

  hideModal() {
    event.preventDefault();
    leave(this.bodyTarget);
    leave(this.backdropTarget).then(() => {
      this.element.parentElement.removeAttribute("src");
      this.element.remove();
    })
  }

  handleSubmit = (e) => {
    if (e.detail.success) {
      this.hideModal()
    }
  }

  handleKeyup(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  clickOutside(event) {
    event.preventDefault()
    this.hideModal()
  }
}
