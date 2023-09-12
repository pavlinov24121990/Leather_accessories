import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart-items-quantity"
export default class extends Controller {
  static targets = ['quantity'];

   handleFormChange(event) {
     this.element.closest("form").requestSubmit();
  }
}
