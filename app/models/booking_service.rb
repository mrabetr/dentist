class BookingService < ApplicationRecord
  belongs_to :booking
  belongs_to :service

  validates_uniqueness_of :service_id, scope: [:booking_id]
end
