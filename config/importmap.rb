# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-dropdown", to: "https://ga.jspm.io/npm:stimulus-dropdown@2.0.0/dist/stimulus-dropdown.es.js"
pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.50.0/dist/index.js"
pin "chartkick", to: "chartkick.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.6/src/index.js"
