class AddPricePublicToServices < ActiveRecord::Migration[6.0]
  def change
    add_monetize :services, :price, currency: { present: false }
    add_column :services, :public, :boolean, default: false
  end
end
