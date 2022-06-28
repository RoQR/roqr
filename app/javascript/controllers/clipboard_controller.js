import { Controller } from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'

export default class extends Controller {
  static targets = [ "copyIcon", "confirmedIcon", "source" ]

  copy() {
    event.preventDefault()
    navigator.clipboard.writeText(this.sourceTarget.value)
    leave(this.copyIconTarget).then(() => {
        enter(this.confirmedIconTarget);
    });

    setTimeout(() => {
      leave(this.confirmedIconTarget).then(() => {
        enter(this.copyIconTarget);
    })}, 2000);
  }
}
