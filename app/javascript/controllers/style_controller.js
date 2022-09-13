// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['newStyle', 'dotsColor', 'backgroundColor', 'cornerSquaresColor', 'cornerDotsColor']

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

  async newStyleTargetConnected(element) {
    let id = element.value;
    if (id) {
      let values = await this.getStyleValues(id);
      this.applyStyleValues(values);
    }
  }

  applyStyleValues(values) {
    this.dotsColorTarget.value = values['dots_color']
    this.backgroundColorTarget.value = values['background_color']
    this.cornerSquaresColorTarget.value = values['corner_squares_color']
    this.cornerDotsColorTarget.value = values['corner_dots_color']
  }
}

