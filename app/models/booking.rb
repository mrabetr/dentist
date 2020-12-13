class Booking < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_many :booking_services, dependent: :destroy
  has_many :services, through: :booking_services
  accepts_nested_attributes_for :booking_services, allow_destroy: true

  STATUS = ["Pending", "Complete", "Cancelled"]

  validates :start_time, presence: true
  validates :status, presence: true, inclusion: { in: STATUS }
  validates_uniqueness_of :doctor_id, scope: [:start_time]
end
