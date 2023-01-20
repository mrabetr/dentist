// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import Calendar from '@toast-ui/calendar';

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    const container = document.getElementById('calendar');
    const options = {
      defaultView: 'week',
      week: {
        taskView: false,
      },
      timezone: {
        zones: [
          {
            timezoneName: 'Europe/London',
            displayLabel: 'London',
          },
        ],
      },
      calendars: [
        {
          id: 'calendar',
          name: 'Work',
          backgroundColor: '#03bd9e',
        },
      ],
    };

    // const calendar = new Calendar(container, options);
    this.calendar = new Calendar(container, options);
  }
}
