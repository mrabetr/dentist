class BookingService < ApplicationRecord
  belongs_to :booking
  belongs_to :service
end
