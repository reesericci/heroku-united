// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import LocalTime from "local-time"
import "trix"
import "@rails/actiontext"
LocalTime.start()

document.addEventListener("turbo:morph", () => {
  LocalTime.run()
})
