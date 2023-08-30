import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-add-product"
export default class extends Controller {
  static targets = ["container"];

  add(event) {
    event.preventDefault();
    const time = new Date().getTime();
    const content = `
      <div class="mb-3" data-controller="form-remove-product">
        <label class="form-label" for="category_products_attributes_${time}_title">Title</label>
        <input class="form-control" type="text" name="category[products_attributes][${time}][title]" id="category_products_attributes_${time}_title" placeholder="Title">
        
        <label class="form-label" for="category_products_attributes_${time}_description">Description</label>
        <input class="form-control" type="text" name="category[products_attributes][${time}][description]" id="category_products_attributes_${time}_description" placeholder="Description">
        
        <label class="form-label" for="category_products_attributes_${time}_price">Price</label>
        <input class="form-control" type="text" name="category[products_attributes][${time}][price]" id="category_products_attributes_${time}_price" placeholder="Price">

        <label class="form-label" for="category_products_attributes_${time}_images">Images</label>
        <input class="form-control mb-3" type="file" name="category[products_attributes][${time}][images]" id="category_products_attributes_${time}_images">
        
        <div data-form-add-images-target='images'>
        </div>

        <button data-action="click->form-add-images#add" class="btn btn-success mb-3" type="button">Add Images</button> </br>

        <button data-action="form-remove-product#remove" class="btn btn-danger" type="button">Remove Product</button>
      </div>
    `;
    this.containerTarget.insertAdjacentHTML("beforeend", content);
  }
}

      
  
