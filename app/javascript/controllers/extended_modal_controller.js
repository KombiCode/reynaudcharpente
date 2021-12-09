import { Modal } from "tailwindcss-stimulus-components"

export default class ExtendedModal extends Modal {

  open(e) {
    super.open(e);
    document.addEventListener("modal:loaded", () => {
      this.containerTarget.classList.remove(this.toggleClass);
    }, { once: true });
    document.addEventListener("submit:success", () => {
      this.close()
    }, { once: true });
 
    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');
    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml);
    this.background = document.querySelector(`#${this.backgroundId}`);
  }
}