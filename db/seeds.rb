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

user1 = User.new(email: "mrabetr@hotmail.com", password: "123456")
patient1 = Patient.new
user1.profile = patient1
user1.save
# user1.profile = Patient.create!(user: user1)

# user2 = User.new(email: "imenebia@hotmail.fr", password: "123456")
# user2.profile = Doctor.create!(user: user1)
