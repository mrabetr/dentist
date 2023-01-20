# json.array! @bookings, :id, :start_time, :end_time
json.array! @bookings do |booking|
  # json.(booking, :id, :start_time, :end_time)
  json.id           booking.id
  json.calendarId   "calendar"
  json.title        booking.patient.name
  json.start        booking.start_time
  json.end          booking.end_time
end
