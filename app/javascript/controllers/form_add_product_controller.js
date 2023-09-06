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
        <input class="form-control mb-3" multiple accept="image/*" type="file" name="category[products_attributes][${time}][images][]" id="image_files_${time}">
        <div id="preview_${time}" class="d-flex flex-row">
        </div>

        <button data-action="form-remove-product#remove" class="btn btn-danger" type="button">Remove Product</button>
      </div>
    `;
    this.containerTarget.insertAdjacentHTML("beforeend", content);

    const previewContainer = document.getElementById(`preview_${time}`);
    
    document.getElementById(`image_files_${time}`).addEventListener('change', (event) => {
      previewContainer.innerHTML = ''; 

      const files = event.target.files;
      for (const file of files) {
        const imgContainer = document.createElement('div');
        imgContainer.className = 'preview-image-container';

        const img = document.createElement('img');
        img.src = URL.createObjectURL(file);
        img.className = 'preview-image';
        imgContainer.appendChild(img);

        const deleteBtn = document.createElement('button');
        deleteBtn.className = 'btn btn-danger btn-sm delete-btn';
        deleteBtn.innerText = 'Delete';
        deleteBtn.addEventListener('click', () => {
            imgContainer.remove();
            this.removeFileFromInput(file, time);
        });
        imgContainer.appendChild(deleteBtn);

        previewContainer.appendChild(imgContainer);
      }
    });
  }
    removeFileFromInput(fileToRemove, time) {
    const inputElement = document.getElementById(`image_files_${time}`);
    const files = Array.from(inputElement.files);
    const index = files.indexOf(fileToRemove);
    
    if (index !== -1) {
      files.splice(index, 1);

      const newInput = document.createElement('input');
      newInput.type = 'file';
      newInput.multiple = true;
      newInput.name = inputElement.name;
      newInput.id = inputElement.id;
      newInput.classList = inputElement.classList
      
      const newFileList = new DataTransfer();
      files.forEach((file) => {
        newFileList.items.add(file);
      });
      newInput.files = newFileList.files;

      inputElement.parentNode.replaceChild(newInput, inputElement);
      
      newInput.addEventListener('change', (event) => {
        this.handleFileChange(event);
      });
    }
    
  }
}

      
  
