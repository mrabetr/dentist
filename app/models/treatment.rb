class Treatment < ApplicationRecord
  belongs_to :patient
  has_many :bookings
  has_many :procedures, dependent: :destroy

  accepts_nested_attributes_for :procedures, allow_destroy: true
end
