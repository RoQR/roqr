import { Application } from "@hotwired/stimulus"
import Autosave from 'stimulus-rails-autosave'
import Dropdown from 'stimulus-dropdown'
import "chartkick"
import "Chart.bundle"

const application = Application.start()
application.register('autosave', Autosave)
application.register('dropdown', Dropdown)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
