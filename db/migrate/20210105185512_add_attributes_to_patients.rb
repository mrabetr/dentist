class AddAttributesToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :dob, :date
    add_column :patients, :street, :string
    add_column :patients, :city, :string
    add_column :patients, :postcode, :string
    add_column :patients, :sex, :string
    add_column :patients, :communication, :string
    add_column :patients, :last_visit, :date
    add_column :patients, :gp, :string
    add_column :patients, :gp_street, :string
    add_column :patients, :gp_city, :string
    add_column :patients, :gp_postcode, :string
    add_column :patients, :gp_tel, :string
  end
end
