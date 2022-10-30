import {Controller} from "@hotwired/stimulus"
import { useTransition } from 'stimulus-use'

export default class extends Controller {
  static targets = ["buttons", "countdown"]

  connect() {
    useTransition(this);
    const timeoutSeconds = parseInt(this.data.get("timeout"));

    // Display with transition
    setTimeout(() => {
      this.enter();

      if (this.hasCountdownTarget) {
        this.countdownTarget.style.animation = `flash-countdown linear ${timeoutSeconds}s`;
      }
    }, 500);

    this.timeoutId = setTimeout(() => {
      this.leave();
    }, timeoutSeconds * 1000 + 500);
  }

  run(e) {
    e.preventDefault();
    this.stop();
    let _this = this;
    this.buttonsTarget.innerHTML = '<span class="text-sm leading-5 font-medium text-grey-700">Processing...</span>';

    // Call the action
    fetch(this.data.get("action-url"), {
      method: this.data.get("action-method").toUpperCase(),
      dataType: 'script',
      credentials: "include",
      headers: {
        "X-CSRF-Token": this.csrfToken
      },
    })
      .then(function (response) {
        let content;

        // Example of the response, content should be provided from the controller
        if (response.status === 200) {
          content = '<span class="text-sm leading-5 font-medium text-green-700">Done!</span>'
        } else {
          content = '<span class="text-sm leading-5 font-medium text-red-700">Error!</span>'
        }

        // Set new content
        _this.buttonsTarget.innerHTML = content;

        // Close
        setTimeout(() => {
          _this.close();
        }, 1000);
      });
  }

  close() {
    this.leave();
  }

  stop() {
    clearTimeout(this.timeoutId)
    this.timeoutId = null
  }

  get csrfToken() {
    const element = document.head.querySelector('meta[name="csrf-token"]')
    return element.getAttribute("content")
  }
}
