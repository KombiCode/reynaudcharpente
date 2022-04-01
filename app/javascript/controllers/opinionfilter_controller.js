import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = ['filter', 'filterable'];

  connect() {
  }

  disconnect() {
    this.close();
  }

  filter(event) {
    event.preventDefault();

    // Use the index of the current target
    const filterCriteria = event.currentTarget.dataset.opinionfilterFilter;

    this.filterableTargets.forEach((filterable, index) => {
      console.log(`filterable : ${filterable}, filter criteria = ${filterCriteria}`);
      filterable.classList.toggle('hidden', filterable.dataset.opinionfilterRating != filterCriteria);
    })

  }

}