class Service < ApplicationRecord
  belongs_to :doctor
  has_many :booking_services, dependent: :destroy
  has_many :bookings, through: :booking_services

  validates :name, presence: true
end
