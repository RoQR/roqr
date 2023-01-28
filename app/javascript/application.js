// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import ahoy from 'ahoy.js';
import LocalTime from "local-time"

LocalTime.start()
ahoy.configure({cookies: false});
