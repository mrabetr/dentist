import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'new' ];

  // connect() {
  //   console.log('Hello!');
  //   console.log(this.newTarget);
  //   console.log(parseInt(this.newTarget.dataset.servicesNo));
  //   this.newTarget.dataset.servicesNo = "2"; // dataset can be re-assigned
  // }

  add(event) {
    // console.log('You clicked');
    // console.log(event);

    // this identifies the div with data-service-target="new"
    const targetInput = this.newTarget;

    // here we're targetting the lastElementChild
    const lastId = targetInput.lastElementChild.id;
    const newId = parseInt(lastId) + 1;

    // here we're targetting the firstElementChild since it will always have id="0"
    const newInput = targetInput.firstElementChild.outerHTML.replace(/0/g, newId);

    // here we're inserting the incremented nested attribute
    targetInput.insertAdjacentHTML('beforeend', newInput);
  }
}
