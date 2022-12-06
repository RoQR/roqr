import { Controller } from "@hotwired/stimulus"
import {enter, leave} from 'el-transition'
import {post} from '@rails/request.js'

export default class extends Controller {
  static targets = [ "copyIcon", "confirmedIcon", "source" ]

  async copy() {
    event.preventDefault()
    navigator.clipboard.writeText(this.sourceTarget.value)
    leave(this.copyIconTarget).then(() => {
        enter(this.confirmedIconTarget);
    });

    setTimeout(() => {
      leave(this.confirmedIconTarget).then(() => {
        enter(this.copyIconTarget);
    })}, 2000);

    await post('/flash', {
      body: JSON.stringify({flash: {type: 'success', data: { title: 'API key copied to your clipboard' }}}),
      responseKind: 'turbo-stream'
    })
  }
}
