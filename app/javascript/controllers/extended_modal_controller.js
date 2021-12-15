import { Modal } from "tailwindcss-stimulus-components"

export default class ExtendedModal extends Modal {

  open(e) {
    document.addEventListener("modal:loaded", () => {
      this.containerTarget.classList.remove(this.toggleClass);
    }, { once: true });
    document.addEventListener("submit:success", () => {
      this.close()
    }, { once: true });

    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');
    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml);
    this.background = document.querySelector(`#${this.backgroundId}`);

    if (this.preventDefaultActionOpening) {
      e.preventDefault();
    }

    if (e.target.blur) {
      e.target.blur();
    }

    // Lock the scroll and save current scroll position
    this.lockScroll();
  }

  _backgroundHTML() {
    return `<div id="${this.backgroundId}" class="fixed top-0 left-0 w-full h-full" style="background-color: rgba(0, 0, 0, 0.7); z-index: 9998;"></div>`;
  }
}