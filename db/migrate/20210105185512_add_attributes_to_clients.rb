class AddAttributesToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :dob, :date
    add_column :clients, :street, :string
    add_column :clients, :city, :string
    add_column :clients, :postcode, :string
    add_column :clients, :sex, :string
  end
end
