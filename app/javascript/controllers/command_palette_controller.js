import { Controller } from "@hotwired/stimulus"
import "ninja-keys"

export default class extends Controller {
  connect() {
    this.element.data = [
      {
        id: 'Links',
        title: 'Open Links',
        hotkey: 'ctrl+L',
        section: 'Links',
        handler: () => {
            Turbo.visit("/links")
        }
      },
      {
        id: 'Events',
        title: 'Open Events',
        hotkey: 'ctrl+E',
        section: 'Events',
        handler: () => {
            Turbo.visit("/events")
        }
      }
    ]
  }
}
