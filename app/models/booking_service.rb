class BookingService < ApplicationRecord
  belongs_to :service
  belongs_to :booking
end
