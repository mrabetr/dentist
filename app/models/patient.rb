class Patient < ApplicationRecord
  has_one :user, as: :profile
  has_many :bookings
  has_many :doctors, through: :bookings
  # accepts_nested_attributes_for :user
end
