pin "application"
pin "@hotwired/turbo-rails"
pin "@hotwired/stimulus"
pin "@hotwired/stimulus-loading"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"

pin "contratos"
pin "asignaciones"   # ← ahora sí funciona

pin_all_from "app/javascript/controllers", under: "controllers"
