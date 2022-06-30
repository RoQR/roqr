# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "ninja-keys", to: "https://ga.jspm.io/npm:ninja-keys@1.2.1/dist/ninja-keys.js"
pin "@lit/reactive-element", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/reactive-element.js"
pin "@lit/reactive-element/decorators/custom-element.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/custom-element.js"
pin "@lit/reactive-element/decorators/event-options.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/event-options.js"
pin "@lit/reactive-element/decorators/property.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/property.js"
pin "@lit/reactive-element/decorators/query-all.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/query-all.js"
pin "@lit/reactive-element/decorators/query-assigned-nodes.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/query-assigned-nodes.js"
pin "@lit/reactive-element/decorators/query-async.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/query-async.js"
pin "@lit/reactive-element/decorators/query.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/query.js"
pin "@lit/reactive-element/decorators/state.js", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.3.2/decorators/state.js"
pin "@material/mwc-icon", to: "https://ga.jspm.io/npm:@material/mwc-icon@0.25.3/mwc-icon.js"
pin "lit", to: "https://ga.jspm.io/npm:lit@2.0.2/index.js"
pin "lit-element/lit-element.js", to: "https://ga.jspm.io/npm:lit-element@3.2.0/lit-element.js"
pin "lit-html", to: "https://ga.jspm.io/npm:lit-html@2.2.6/lit-html.js"
pin "lit-html/directives/class-map.js", to: "https://ga.jspm.io/npm:lit-html@2.2.6/directives/class-map.js"
pin "lit-html/directives/live.js", to: "https://ga.jspm.io/npm:lit-html@2.2.6/directives/live.js"
pin "lit-html/directives/ref.js", to: "https://ga.jspm.io/npm:lit-html@2.2.6/directives/ref.js"
pin "lit-html/directives/repeat.js", to: "https://ga.jspm.io/npm:lit-html@2.2.6/directives/repeat.js"
pin "lit-html/directives/unsafe-html.js", to: "https://ga.jspm.io/npm:lit-html@2.2.6/directives/unsafe-html.js"
pin "lit/decorators.js", to: "https://ga.jspm.io/npm:lit@2.0.2/decorators.js"
pin "lit/directives/class-map.js", to: "https://ga.jspm.io/npm:lit@2.0.2/directives/class-map.js"
pin "lit/directives/live.js", to: "https://ga.jspm.io/npm:lit@2.0.2/directives/live.js"
pin "lit/directives/ref.js", to: "https://ga.jspm.io/npm:lit@2.0.2/directives/ref.js"
pin "lit/directives/repeat.js", to: "https://ga.jspm.io/npm:lit@2.0.2/directives/repeat.js"
pin "lit/directives/unsafe-html.js", to: "https://ga.jspm.io/npm:lit@2.0.2/directives/unsafe-html.js"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@2.4.0/tslib.es6.js"
pin "stimulus-dropdown", to: "https://ga.jspm.io/npm:stimulus-dropdown@2.0.0/dist/stimulus-dropdown.es.js"
pin "el-transition", to: "https://ga.jspm.io/npm:el-transition@0.0.7/index.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.50.0/dist/index.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.9.4/dist/hotkeys.esm.js"
pin "chartkick", to: "chartkick.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.6/src/index.js"
