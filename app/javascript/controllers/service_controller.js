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
    // const newInput = targetInput.firstElementChild.outerHTML.replace(/0/g, newId);
    let newInput = targetInput.firstElementChild.outerHTML.replaceAll('id="0"', `id="${newId}"`);
    newInput = newInput.replaceAll('_0_', `_${newId}_`).replaceAll('[0]', `[${newId}]`);

    // here we're inserting the incremented nested attribute
    targetInput.insertAdjacentHTML('beforeend', newInput);
  }

  remove(event) {
    // this identifies the div with data-service-target="new"
    const targetInput = this.newTarget;

    // here we're targetting the lastElementChild
    const lastId = targetInput.lastElementChild.id;
    if (lastId !== '0') return targetInput.lastElementChild.remove();
  }

  addEdit(event) {
    // this identifies the div with data-service-target="new"
    const targetInput = this.newTarget;
    // console.log(targetInput.childElementCount);
    // console.log(targetInput.firstElementChild);
    // console.log(targetInput.firstElementChild.nextElementSibling);

    // since IDs start at 0 and we always have at least one servie,
    // the next id is simply the count
    const servicesCount = this.newTarget.dataset.servicesCount;
    const newId = servicesCount;

    // here we're targetting the firstElementChild since it will always have id="0"
    // the specific replacement is to avoid replacing the 0 of service id 10
    let newInput = targetInput.firstElementChild.outerHTML.replaceAll('selected="selected" ', '');
    newInput = newInput.replaceAll('_0_', `_${newId}_`).replaceAll('[0]', `[${newId}]`);

    // here we're inserting the incremented nested attribute
    targetInput.insertAdjacentHTML('beforeend', newInput);

    // here we're re-assigning the incremented servicesCount to be used if another service is added
    this.newTarget.dataset.servicesCount = parseInt(newId) + 1;
  }
}
