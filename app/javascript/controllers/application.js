import { Application } from "@hotwired/stimulus"
import Dropdown from 'stimulus-dropdown'
import "chartkick"

const application = Application.start()
application.register('dropdown', Dropdown)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
