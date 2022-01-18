// Credit: This controller is an edited-to-the-essentials version
// of the modal component created by @excid3 as part of the essential 
// tailwind-stimulus-components package found here:
// https://github.com/excid3/tailwindcss-stimulus-components

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ['container'];

  connect() {
    this.toggleClass = 'hidden';
    this.backgroundId = 'modal-background';
    this.backgroundHtml = this._backgroundHTML();
    this.allowBackgroundClose = true;
    this.preventDefaultActionOpening = false;
  }

  disconnect() {
    this.close();
  }

  open(e) {
    if (this.preventDefaultActionOpening) {
      e.preventDefault();
    }

    if (e.target.blur) {
      e.target.blur();
    }

    // Lock the scroll and save current scroll position
    this.lockScroll();

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

  close(e) {
    if (e && this.preventDefaultActionClosing) {
      e.preventDefault();
    }
    // Unlock the scroll and restore previous scroll position
    this.unlockScroll();

    // Hide the modal
    this.containerTarget.classList.add(this.toggleClass);

    // Remove the background
    if (this.background) { this.background.remove() }
  }

  closeBackground(e) {
    if (this.allowBackgroundClose && e.target === this.containerTarget) {
      this.close(e);
    }
  }

  closeWithKeyboard(e) {
    if (e.keyCode === 27 && !this.containerTarget.classList.contains(this.toggleClass)) {
      this.close(e);
    }
  }

  _backgroundHTML() {
    return `<div id="${this.backgroundId}" class="fixed top-0 left-0 w-full h-full" style="background-color: rgba(0, 0, 0, 0.7); z-index: 9998;"></div>`;
  }

  lockScroll() {
    // Add right padding to the body so the page doesn't shift
    // when we disable scrolling
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth;
    document.body.style.paddingRight = `${scrollbarWidth}px`;

    // Save the scroll position
    this.saveScrollPosition();

    // Add classes to body to fix its position
    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');

    // Add negative top position in order for body to stay in place
    document.body.style.top = `-${this.scrollPosition}px`;
  }

  unlockScroll() {
    // Remove tweaks for scrollbar
    document.body.style.paddingRight = null;

    // Remove classes from body to unfix position
    document.body.classList.remove('fixed', 'inset-x-0', 'overflow-hidden');

    // Restore the scroll position of the body before it got locked
    this.restoreScrollPosition();

    // Remove the negative top inline style from body
    document.body.style.top = null;
  }

  saveScrollPosition() {
    this.scrollPosition = window.pageYOffset || document.body.scrollTop;
  }

  restoreScrollPosition() {
    if (this.scrollPosition === undefined) return;

    document.documentElement.scrollTop = this.scrollPosition;
  }
}
