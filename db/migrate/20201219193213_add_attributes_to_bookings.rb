class AddAttributesToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :time, :string
    add_column :bookings, :length, :integer
  end
end
