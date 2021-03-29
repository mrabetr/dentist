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

  addEdit(event) {
    // this identifies the div with data-service-target="new"
    const targetInput = this.newTarget;

    // since IDs start at 0 and we always have at least one procedure,
    // the next id is simply the count
    const proceduresCount = this.newTarget.dataset.proceduresCount;
    const newId = proceduresCount;

    // here we're targetting the firstElementChild since it will always have id="0"
    // the specific replacement is to avoid replacing the 0 of procedure id 10
    let newInput = targetInput.firstElementChild.outerHTML.replaceAll('_0_', `_${newId}_`).replaceAll('[0]', `[${newId}]`);
    console.log(newInput);

    // here we're inserting the incremented nested attribute
    targetInput.insertAdjacentHTML('beforeend', newInput);
    // here we're resetting all values to ""
    targetInput.lastElementChild.querySelectorAll('input').forEach(element => element.value = "");
    // here we're re-assigning the incremented proceduresCount to be used if another procedure is added
    this.newTarget.dataset.proceduresCount = parseInt(newId) + 1;
  }
}
