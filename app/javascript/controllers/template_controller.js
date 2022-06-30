// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'
import { get } from '@rails/request.js'

export default class extends Controller {
  static targets = ['color', 'fill']

  connect() {
    console.log("Connected")
  }

  getTemplateValues(id) {
    const response = get(`/templates/${id}.json`);
    if (response.ok) {
      return response.json;
    }
  }

  apply() {
    let id = event.target.value;
    if (id) {
      let values = getTemplateValues(id);
      applyTemplateValues(values);
    }
  }


  applyTemplateValues(values) {

  }
}

