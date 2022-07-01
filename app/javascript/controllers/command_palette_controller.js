import { Controller } from "@hotwired/stimulus"
import "ninja-keys"

export default class extends Controller {
  connect() {
    this.element.data = [
      {
        id: 'Links',
        title: 'Links',
        hotkey: 'ctrl+L',
        section: 'Links',
        handler: () => {
            Turbo.visit("/links")
        }
      },
      {
        id: 'Scans',
        title: 'Scans',
        hotkey: 'ctrl+S',
        section: 'Scans',
        handler: () => {
            Turbo.visit("/scans")
        }
      },
      {
        id: 'Styles',
        title: 'Styles',
        hotkey: 'ctrl+T',
        section: 'Styles',
        handler: () => {
          Turbo.visit("/styles")
        }
      }
    ]
  }
}
