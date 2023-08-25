class Service < ApplicationRecord
  belongs_to :provider
  has_many :booking_services, dependent: :destroy
  has_many :bookings, through: :booking_services

  monetize :price_cents

  validates :name, presence: true
end
