class ChangeColumnsToStringInMedicalForms< ActiveRecord::Migration[6.0]
  def change
    change_column :medical_forms, :smoking_frequency, :string
    change_column :medical_forms, :alcohol_frequency, :string
  end
end
