import { Application } from "@hotwired/stimulus"
import Dropdown from 'stimulus-dropdown'
import Alpine from 'alpinejs'
import 'alpine-turbo-drive-adapter'

const application = Application.start()
application.register('dropdown', Dropdown)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.Alpine = Alpine

Alpine.start()

export { application }
