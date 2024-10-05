import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  close(e) {
    e.preventDefault();

    this.element.remove();

    const modal = document.getElementById("modal");
    modal.removeAttribute("src");
    modal.removeAttribute("completed");
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.close(e);
    }
  }
}
