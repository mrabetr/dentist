# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all user tables"

Doctor.destroy_all
Patient.destroy_all
Admin.destroy_all
User.destroy_all

puts "creating a user"
admin = User.create!(email: "admin@hotmail.com", password: "123456",
  first_name: "Rafik", last_name: "Mravet")
puts "making user admin"
admin.admin_profile!

puts "adding doctors"
doctor1 = User.create!(email: "doctor1@hotmail.com", password: "123456",
  first_name: "Leila", last_name: "Nevia")
doctor1.doctor_profile!

doctor2 = User.create!(email: "doctor2@hotmail.com", password: "123456",
  first_name: "John", last_name: "Smith")
doctor2.doctor_profile!

puts "adding patients"
patient1 = User.create!(email: "patient1@hotmail.com", password: "123456",
  first_name: "Sarah", last_name: "Smith")
patient2 = User.create!(email: "patient2@hotmail.com", password: "123456",
  first_name: "Peter", last_name: "Jones")
patient3 = User.create!(email: "patient3@hotmail.com", password: "123456",
  first_name: "Ali", last_name: "Ben")
puts "finished adding users!"

puts "adding services"
service1 = Service.new(name: "Check up")
service1.doctor = doctor1.profile
service1.save!

service2 = Service.new(name: "Invisalign")
service2.doctor = doctor1.profile
service2.save!

puts "adding bookings"
booking1 = Booking.new(start_time: Date.today, end_time: Date.today, status: "Pending")
booking1.doctor = doctor1.profile
booking1.patient = patient1.profile
booking1.save!

puts "adding booking services"
booking1_service1 = BookingService.new
booking1_service1.booking = booking1
booking1_service1.service = service1
booking1_service1.save!

booking1_service2 = BookingService.new
booking1_service2.booking = booking1
booking1_service2.service = service2
booking1_service2.save!
puts "finished!"

# user1 = User.new(email: "mrabetr@hotmail.com", password: "123456")
# patient1 = Patient.new
# user1.profile = patient1
# user1.save
# user1.profile = Patient.create!(user: user1)

# user2 = User.new(email: "imenebia@hotmail.fr", password: "123456")
# user2.profile = Doctor.create!(user: user1)
