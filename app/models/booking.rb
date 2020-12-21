class Booking < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_many :booking_services, dependent: :destroy
  has_many :services, through: :booking_services
  accepts_nested_attributes_for :booking_services, allow_destroy: true

  STATUS = ["Pending", "Completed", "Cancelled"]
  TIME = []
  (8..19).each do |hour|
    (0..1).each do |m|
      TIME << Time.parse("#{hour}:#{m * 30}").strftime("%H:%M")
    end
  end
  LENGTH = [30, 60, 90, 120]

  # validates :date, future_date_only: true
  validates :start_time, presence: true
  validates :status, presence: true, inclusion: { in: STATUS }
  validates_uniqueness_of :start_time, scope: [:doctor_id]
end
