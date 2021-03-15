class Treatment < ApplicationRecord
  belongs_to :patient
  has_many :bookings
  has_many :procedures, dependent: :destroy
  has_many :payments

  accepts_nested_attributes_for :procedures, allow_destroy: true

  def reference
    "Plan no #{id} - #{patient.name}"
  end
end
