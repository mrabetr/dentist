# json.array! @bookings, :id, :start_time, :end_time
json.array! @bookings do |booking|
  # json.(booking, :id, :start_time, :end_time)
  title = booking.client.name
  title += " 🗒️ #{booking.popup_note}" if booking.popup_note.present?

  json.id           booking.id
  json.calendarId   "calendar"
  json.title        title
  json.start        booking.start_time
  json.end          booking.end_time
end
