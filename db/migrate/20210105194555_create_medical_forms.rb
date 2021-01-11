class CreateMedicalForms < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_forms do |t|
      t.boolean :anaemia, default: false
      t.boolean :diabetes, default: false
      t.boolean :epilepsy, default: false
      t.boolean :cancer, default: false
      t.boolean :brain_surgery, default: false
      t.boolean :arthritis, default: false
      t.boolean :cold_sore, default: false
      t.boolean :gatristis, default: false
      t.boolean :drug_dependence, default: false
      t.boolean :blood_pressure, default: false
      t.boolean :fainting_blackouts, default: false
      t.boolean :headaches_migraines, default: false
      t.boolean :allergies, default: false
      t.boolean :heart_conditions, default: false
      t.boolean :rheumatic_fever, default: false
      t.boolean :liver_kidney_problems, default: false
      t.boolean :chest_problems, default: false
      t.boolean :joint_replacement_implants, default: false
      t.boolean :bad_anaesthesia_reaction, default: false
      t.boolean :hospital_treatments, default: false
      t.boolean :hiv, default: false
      t.boolean :pregnant_nursing, default: false
      t.date :due_date
      t.boolean :smoking, default: false
      t.integer :smoking_frequency
      t.boolean :alcohol, default: false
      t.integer :alcohol_frequency
      t.text :other_medical_info
      t.boolean :teeth_pain, default: false
      t.boolean :teeth_sensitivity, default: false
      t.boolean :bleeding, default: false
      t.boolean :unpleasant_taste, default: false
      t.boolean :food_trap, default: false
      t.boolean :mouth_ulcers, default: false
      t.boolean :grinding_teeth, default: false
      t.boolean :stained_teeth, default: false
      t.boolean :uneven_teeth, default: false
      t.boolean :black_filling, default: false
      t.boolean :cracked_teeth, default: false
      t.boolean :missing_teeth, default: false
      t.boolean :crooked_teeth, default: false
      t.boolean :uncomfortable_dentures, default: false
      t.boolean :bad_breath, default: false
      t.text :other_smile_info
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
