class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.monetize :amount, currency: { present: false }
      t.references :treatment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
