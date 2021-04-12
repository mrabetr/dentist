class Booking < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_many :booking_services, dependent: :destroy
  has_many :services, through: :booking_services
  has_one :note, dependent: :destroy
  accepts_nested_attributes_for :booking_services, allow_destroy: true

  monetize :amount_cents

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

  # the below is commented out otherwise you can't save a booking without having a treatment referenced
  # belongs_to :treatment
  # this methid has been added to access treatment from a booking e.g. @booking.treamnent
  def treatment
    Treatment.find(treatment_id)
  end

  def sms_notification
    dr_name = "Dr #{doctor.user.last_name}"
    dr_mobile = doctor.user.mobile
    patient_name = patient.user.first_name
    patient_mobile = patient.user.mobile
    booking_time = start_time.strftime('%a, %e %b %Y at %H:%M')
    message = "Hi #{patient_name}, this is a reminder that your dental appointment is scheduled on #{booking_time}. Looking forward to seeing you. Thanks -- #{dr_name}, Design Dental Clinic. (Please call or message #{dr_mobile} if unable to attend)"
    sms = TwilioSms.new(from: dr_name, to: patient_mobile, message: message)
    sms.call
  end
end
