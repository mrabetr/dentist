class AddTreatmentIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :treatment, foreign_key: true
  end
end
