import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'new' ];

  add(event) {
    // this identifies the div with data-procedure-target="new"
    const targetInput = this.newTarget;

    // here we're targetting the lastElementChild
    const lastId = targetInput.lastElementChild.id;
    const newId = parseInt(lastId) + 1;

    // here we're targetting the firstElementChild since it will always have id="0"
    // first we replace the price value of "0.00" so that it doesn't get replaced by the newId
    const updatedInput = targetInput.firstElementChild.outerHTML.replace("0.00", "x.xx");
    let newInput = updatedInput.replace(/0/g, newId);
    newInput = newInput.replace("x.xx", "0.00");

    // here we're inserting the incremented nested attribute
    targetInput.insertAdjacentHTML('beforeend', newInput);
  }

  remove(event) {
    // this identifies the div with data-procedure-target="new"
    const targetInput = this.newTarget;

    // here we're targetting the lastElementChild
    const lastId = targetInput.lastElementChild.id;
    if (lastId !== '0') return targetInput.lastElementChild.remove();
  }
}
