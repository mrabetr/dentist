class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
