class AddPopupNotesToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :popup_note, :text
  end
end
