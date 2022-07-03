// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['color', 'fill', 'positionBorder', 'positionCore']

  async getStyleValues(id) {
    const response = await get(`/api/v0/styles/${id}`);
    if (response.ok) {
      return await response.json;
    }
  }

  async apply() {
    let id = event.target.value;
    if (id) {
      let values = await this.getStyleValues(id);
      this.applyStyleValues(values);
    }
  }

  applyStyleValues(values) {
    this.colorTarget.value = values['color']
    this.fillTarget.value = values['fill']
    this.positionBorderTarget.value = values['position_border_color']
    this.positionCoreTarget.value = values['position_core_color']
  }
}

