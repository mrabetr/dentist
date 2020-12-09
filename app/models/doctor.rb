class Doctor < ApplicationRecord
  has_one :user, as: :profile
  has_many :services
  has_many :bookings
  has_many :patients, through: :bookings
  # accepts_nested_attributes_for :user
end
