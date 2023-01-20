import { Controller } from "stimulus"
import Calendar from '@toast-ui/calendar';

export default class extends Controller {

  getCalendarData() {
    let url = '/bookings.json'
    fetch(url)
    .then(response => response.json())
    .then(response => response.forEach(booking => {
      this.calendar.createEvents([
        {
          id: booking.id,
          calendarId: booking.calendarId,
          title: booking.title,
          start: booking.start,
          end: booking.end,
        },
      ])
    }))
  }

  connect() {
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

    // Creating multiple events
    // this.calendar.createEvents([
    //   {
    //     id: 'event1',
    //     calendarId: 'calendar',
    //     title: 'Weekly Meeting',
    //     start: '2023-01-20T15:00:00',
    //     end: '2023-01-20T16:00:00',
    //   },
    // ]);

    // const firstEvent = this.calendar.getEvent('event1', 'calendar');

    // console.log(firstEvent.title); // 'Weekly Meeting'
    this.getCalendarData();
  }
}
