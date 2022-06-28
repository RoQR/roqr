// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {
  static targets = ['closeButton', 'openButton', 'menu']

  open() {
    enter(this.menuTarget);
    leave(this.openButtonTarget).then(() => {
        enter(this.closeButtonTarget);
    });
  }

  close() {
    leave(this.menuTarget);
    leave(this.closeButtonTarget).then(() => {
        enter(this.openButtonTarget);
    });
  }

  toggle() {
    if (this.menuTarget.classList.contains('hidden')) {
      this.open()
    } else {
      this.close()
    }
  }
}
