import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "detail" ]

  toggle(event) {
    if (event.target.checked) {
      this.detailTarget.style.display = '';
    } else {
      this.detailTarget.style.display = 'none';
    }
  }
}

