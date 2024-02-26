import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  new(event) {
    event.preventDefault();

    const commentId = event.target.dataset.commentId;
    const template = document.getElementById(`reply_form_${commentId}`);
    const form = template.content.cloneNode(true).firstElementChild.outerHTML;
    template.insertAdjacentHTML('afterend', form);

    // Check if the submission was successful, then remove the form
    const insertedForm = template.nextElementSibling;
    insertedForm.addEventListener('turbo:submit-end', (e) => {
      if (e.detail.success) {
        insertedForm.remove();
      }
    });
  }
}
