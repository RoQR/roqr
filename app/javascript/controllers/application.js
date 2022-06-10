import { Application } from "@hotwired/stimulus"
import Alpine from 'alpinejs'
import 'alpine-turbo-drive-adapter'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.Alpine = Alpine

Alpine.start()

export { application }
