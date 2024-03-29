import { Controller } from "stimulus"
import Calendar from '@toast-ui/calendar';
import DatePicker from 'tui-date-picker';
import TimePicker from 'tui-time-picker';
import Rails from "@rails/ujs"

export default class extends Controller {

  showCalendarBooking() {
    let calendar = this.calendar;
    calendar.on('clickEvent', (event) => {

      Rails.ajax({
        type: "GET",
        url: `/bookings/${event.event.id}`,
        success: function(result) {
          window.location = `/bookings/${event.event.id}`;
        },
      })
    })
  }

  newCalendarBooking() {
    let calendar = this.calendar;
    calendar.on('selectDateTime', (event) => {
      const start_time = event.start
      const end_time = event.end
      const date = start_time.toISOString().split('T')[0]
      // const time = start_time.toISOString().split('T')[1].substring(0, 5)
      const time = start_time.toTimeString().split()[0].substring(0, 5)
      const length = (end_time.getTime() - start_time.getTime()) / (1000 * 60)

      Rails.ajax({
        type: "GET",
        url: `/bookings/new`,
        success: function(result) {
          window.location = `/bookings/new?date=${date}&time=${time}&length=${length}`;
        },
      })
    })
  }

  updateCalendarBooking() {
    let calendar = this.calendar;
    calendar.on('beforeUpdateEvent', (event) => {
      const booking_id = event.event.id
      let start_time = event.event.start.d.d
      event.changes.start && (start_time = event.changes.start.d.d)
      const end_time = event.changes.end.d.d
      // const time = start_time.toISOString().split('T')[1].substring(0, 5)
      const time = start_time.toTimeString().split()[0].substring(0, 5)
      const length = (end_time.getTime() - start_time.getTime()) / (1000 * 60)

      let formData = new FormData()
      formData.append('[booking]start_time', start_time);
      formData.append('[booking]end_time', end_time);
      formData.append('[booking]time', time);
      formData.append('[booking]length', length);

      calendar.updateEvent(booking_id, 'calendar', event.changes);

      Rails.ajax({
        type: "PATCH",
        url: `/bookings/${booking_id}/update_booking`,
        data: formData
      })
    })
  }

  // newCalendarBooking() {
  //   let calendar = this.calendar;
  //   calendar.on('selectDateTime', (event) => {
  //     let formData = new FormData()
  //     formData.append('[booking]start_time', event.start);
  //     formData.append('[booking]end_time', event.end);
  //     // console.log(formData.get('[booking]start_time'));
  //     const start_time = event.start
  //     const end_time = event.end
  //     const length = (end_time.getTime() - start_time.getTime()) / (1000 * 60)
  //     console.log(length)
  //     Rails.ajax({
  //       type: "POST",
  //       url: '/bookings/new_booking',
  //       data: formData
  //     })
  //   })
  //   // calendar.on('clickEvent', (event) => {
  //   //   console.log('clickEvent', event)
  //   // })
  //   // calendar.fire('beforeCreateEvent', {
  //   //   title: "test title",
  //   // });
  //   // calendar.on('beforeCreateEvent', (event) => {
  //   //   // const booking = {
  //   //   //   id: 1,
  //   //   //   calendarId: 'calendar',
  //   //   //   title: event.title,
  //   //   //   category: 'time',
  //   //   //   location: event.location,
  //   //   //   start: event.start,
  //   //   //   end: event.end
  //   //   // }
  //   //   console.log('clickEvent', event)
  //   //   // event.title = 'New Booking'

  //   //   // calendar.createEvents([booking]);

  //   //   let formData = new FormData()
  //   //   formData.append('[booking]title', event.title);
  //   //   formData.append('[booking]start', event.start.toDate());
  //   //   formData.append('[booking]end', event.end.toDate());
  //   //   formData.append('[booking]location', event.location);
  //   //   console.log(formData.get('[booking]title'));
  //   //   console.log(event.goingDuration);
  //   //   console.log(event.start.toDate());
  //   //   console.log(event.title);

  //   //   Rails.ajax({
  //   //     type: "POST",
  //   //     url: '/bookings/new_booking',
  //   //     data: formData
  //   //   })
  //   // });
  // }

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
      defaultView: 'day',
      // useFormPopup: true,
      // useDetailPopup: true,
      template: {
        timegridDisplayPrimaryTime({ time }) {
          return `${time.getHours()}:00`;
        },
      },
      week: {
        taskView: false,
        hourStart: 7,
        hourEnd: 21,
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

    const params = new URLSearchParams(window.location.search);
    let date = params.get('start_date');
    // date ||= new Date();
    // console.log(params.get('start_date'));
    // console.log(date);

    date && this.calendar.setDate(date);

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
    this.newCalendarBooking();
    this.showCalendarBooking();
    this.updateCalendarBooking();
  }
}
