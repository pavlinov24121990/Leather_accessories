import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-add-images"
export default class extends Controller {

  add(event) {
    event.preventDefault();
    const time = new Date().getTime();
    
    const parentTime = event.target.parentElement.dataset.time
    const images_div = event.target.parentElement.querySelector(`#images_${parentTime}`)

    const content = `
      <div class="mb-3" data-controller="form-remove-images">

        <input class="form-control mb-3" type="file" name="category[products_attributes][${time}][images]" id="category_products_attributes_${time}_images">

        <button data-action="form-remove-images#remove" class="btn btn-danger" type="button">Remove Images</button>
      </div>
    `;
    images_div.insertAdjacentHTML("beforeend", content);
  }
}
