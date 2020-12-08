class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      # t.references :user, index: true
      t.timestamps
    end
  end
end
