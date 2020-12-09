class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :title, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile, :string
    add_column :users, :doctor, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
