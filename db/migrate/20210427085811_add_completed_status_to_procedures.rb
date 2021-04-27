class AddCompletedStatusToProcedures < ActiveRecord::Migration[6.0]
  def change
    add_column :procedures, :completed, :boolean, default: false
  end
end
