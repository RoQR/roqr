import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {
  static targets = [ 'item' ]

  toggle() {
    this.itemTargets.forEach(item => {
      toggle(item)
    })
  }

  show() {
    this.itemTargets.forEach(item => {
      enter(item)
    })
  }

  hide() {
    this.itemTargets.forEach(item => {
      leave(item)
    })
  }
}

