# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Doctor.destroy_all
# Patient.destroy_all
# User.destroy_all

user1 = User.create!(email: "mrabetr@hotmail.com", password: "123456")
user2 = User.create!(email: "imenebia@hotmail.fr", password: "123456", doctor: true)

service1 = Service.new(name: "check-up")
service1.user = user2
service1.save!
# user2.update!(doctor: true)
booking1 = Booking.new(start_time: Date.today, end_time: Date.today, status: "pending")
booking1.user = user1
booking1.save!

booking_service1 = BookingService.new
booking_service1.booking = booking1
booking_service1.service = service1
booking_service1.save!
# patient1 = Patient.new
# user1.profile = patient1
# user1.save
# user1.profile = Patient.create!(user: user1)

# user2 = User.new(email: "imenebia@hotmail.fr", password: "123456")
# user2.profile = Doctor.create!(user: user1)
