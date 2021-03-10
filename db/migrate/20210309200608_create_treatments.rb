class CreateTreatments < ActiveRecord::Migration[6.0]
  def change
    create_table :treatments do |t|
      t.string :name
      t.text :recommendations
      t.text :discussion
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
