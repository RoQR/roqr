import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener('turbo:submit-end', this.submitEnd)
  }

  disconnect() {
    document.removeEventListener('turbo:submit-end', this.submitEnd)
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src");
    this.element.remove();
  }

  submitEnd = (e) => {
    if (e.detail.success) {
      this.hideModal()
    }
  }
}
