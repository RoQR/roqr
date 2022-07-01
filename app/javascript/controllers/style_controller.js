// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['color', 'fill']

  connect() {
    console.log("Connected")
  }

  async getStyleValues(id) {
    const response = await get(`/styles/${id}.json`);
    if (response.ok) {
      return await response.json;
    }
  }

  async apply() {
    let id = event.target.value;
    if (id) {
      let values = await this.getStyleValues(id);
      console.log(values)
      this.applyStyleValues(values);
    }
  }

  applyStyleValues(values) {
    this.colorTarget.value = values['color']
    this.fillTarget.value = values['fill']
  }
}

