class AddParentToChildrenUsers < ActiveRecord::Migration[6.0]
  def up
    add_reference :users, :parent, polymorphic: true, index: true
    add_column :users, :is_child, :boolean, null: false, default: false
    remove_index :users, :email
    add_index :users, [:email, :first_name], unique: true
  end

  def down
    remove_reference :users, :parent, polymorphic: true, index: true
    remove_column :users, :is_child, :boolean, null: false, default: false
    remove_index :users, [:email, :first_name]
    add_index :users, :email, unique: true
  end
end
