// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['color', 'fill']

  connect() {
    console.log("Connected")
  }

  getStyleValues(id) {
    const response = get(`/styles/${id}.json`);
    if (response.ok) {
      return response.json;
    }
  }

  apply() {
    let id = event.target.value;
    if (id) {
      let values = getStyleValues(id);
      applyStyleValues(values);
    }
  }


  applyStyleValues(values) {

  }
}

