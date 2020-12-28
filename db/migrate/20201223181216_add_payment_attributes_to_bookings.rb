class AddPaymentAttributesToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :state, :string
    add_column :bookings, :checkout_session_id, :string
    add_monetize :bookings, :amount, currency: { present: false }
  end
end
