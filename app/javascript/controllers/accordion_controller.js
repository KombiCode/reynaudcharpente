import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ['title', 'body'];

  connect() {
    this.toggleAccordion();
  }

  disconnect() {
    this.close();
  }

  change(event) {
    event.preventDefault();
    // Use the index of the current target
    this.index = this.titleTargets.indexOf(event.currentTarget);
  }

  toggleAccordion() {
    this.titleTargets.forEach((title, index) => {
      const body = this.bodyTargets[index]
      const arrow = body.parentElement.querySelector(".accordion-arrow");
      if (index === this.index) {
        body.classList.toggle('hidden');
        arrow.classList.toggle('active');
      }
    })
  }

  get index() {
    return parseInt(this.data.get('index') || 0);
  }

  set index(value) {
    this.data.set('index', (value >= 0 ? value : 0));
    this.toggleAccordion();
  }

}