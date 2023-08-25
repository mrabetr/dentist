# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all user tables"

Provider.destroy_all if Rails.env.development?
Client.destroy_all if Rails.env.development?
Admin.destroy_all if Rails.env.development?
User.destroy_all if Rails.env.development?

puts "creating a user"
admin = User.create!(email: "admin@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "Rafik", last_name: "Mrabet")
puts "making user admin"
admin.admin_profile!

puts "adding providers"
provider1 = User.create!(email: "provider1@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "Ali", last_name: "Bekada")
provider1.provider_profile!

provider2 = User.create!(email: "provider2@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "John", last_name: "Smith")
provider2.provider_profile!

puts "adding clients"
client1 = User.create!(email: "client1@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "Sarah", last_name: "Smith")
client2 = User.create!(email: "client2@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "Peter", last_name: "Jones")
client3 = User.create!(email: "client3@appointmentsapp.com", password: ENV['NEW_USER_PASSWORD'],
  first_name: "Rafik", last_name: "Ben")
puts "finished adding users!"

puts "adding services"
service1 = Service.new(name: "Maths")
service1.provider = provider1.profile
service1.save!

service2 = Service.new(name: "English")
service2.provider = provider1.profile
service2.save!

# puts "adding bookings"
# booking1 = Booking.new(start_time: Date.today, end_time: Date.today, status: "Pending")
# booking1.provider = provider1.profile
# booking1.client = client1.profile
# booking1.save!

# puts "adding booking services"
# booking1_service1 = BookingService.new
# booking1_service1.booking = booking1
# booking1_service1.service = service1
# booking1_service1.save!

# booking1_service2 = BookingService.new
# booking1_service2.booking = booking1
# booking1_service2.service = service2
# booking1_service2.save!
puts "finished!"

# user1 = User.new(email: "mrabetr@hotmail.com", password: "123456")
# client1 = client.new
# user1.profile = client1
# user1.save
# user1.profile = client.create!(user: user1)

# user2 = User.new(email: "imenebia@hotmail.fr", password: "123456")
# user2.profile = provider.create!(user: user1)
