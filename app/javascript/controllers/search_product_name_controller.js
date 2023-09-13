import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-product-name"
export default class extends Controller {

  static targets = ['search'];

  handleInputChange(event) {
    this.element.closest("form").requestSubmit();
  }
    
}
