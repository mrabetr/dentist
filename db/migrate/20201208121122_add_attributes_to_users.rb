class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :title, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile, :string
    add_reference :users, :profile, polymorphic: true, index: true
  end
end
