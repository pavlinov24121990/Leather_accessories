import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-add-images"
export default class extends Controller {
  connect() {
   const previewContainer = document.getElementById('preview');
    
    document.getElementById('image_files').addEventListener('change', (event) => {
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
            this.removeFileFromInput(file);
        });
        imgContainer.appendChild(deleteBtn);

        previewContainer.appendChild(imgContainer);
      }
    });
  }
    removeFileFromInput(fileToRemove) {
    const inputElement = document.getElementById('image_files');
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


