import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-remove-images"
export default class extends Controller {
   remove(event) {
    event.preventDefault();
    this.element.remove();
  }
}
