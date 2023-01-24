// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
import Autosave from 'stimulus-rails-autosave';
import Chart from 'stimulus-chartjs'

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
application.register('autosave', Autosave);
application.register('chart', Chart);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
