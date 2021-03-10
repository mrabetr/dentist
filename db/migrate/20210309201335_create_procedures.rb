class CreateProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :procedures do |t|
      t.string :procedure
      t.string :justification
      t.monetize :price, currency: { present: false }
      t.references :treatment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
