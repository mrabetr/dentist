class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
