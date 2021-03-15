# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_15_100933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "booking_services", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_booking_services_on_booking_id"
    t.index ["service_id"], name: "index_booking_services_on_service_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status", default: "Pending"
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "time"
    t.integer "length"
    t.string "state"
    t.string "checkout_session_id"
    t.integer "amount_cents", default: 0, null: false
    t.bigint "treatment_id"
    t.index ["doctor_id"], name: "index_bookings_on_doctor_id"
    t.index ["patient_id"], name: "index_bookings_on_patient_id"
    t.index ["treatment_id"], name: "index_bookings_on_treatment_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medical_forms", force: :cascade do |t|
    t.boolean "anaemia", default: false
    t.boolean "diabetes", default: false
    t.boolean "epilepsy", default: false
    t.boolean "cancer", default: false
    t.boolean "brain_surgery", default: false
    t.boolean "arthritis", default: false
    t.boolean "cold_sore", default: false
    t.boolean "gatristis", default: false
    t.boolean "drug_dependence", default: false
    t.boolean "blood_pressure", default: false
    t.boolean "fainting_blackouts", default: false
    t.boolean "headaches_migraines", default: false
    t.boolean "allergies", default: false
    t.boolean "heart_conditions", default: false
    t.boolean "rheumatic_fever", default: false
    t.boolean "liver_kidney_problems", default: false
    t.boolean "chest_problems", default: false
    t.boolean "joint_replacement_implants", default: false
    t.boolean "bad_anaesthesia_reaction", default: false
    t.boolean "hospital_treatments", default: false
    t.boolean "hiv", default: false
    t.boolean "pregnant_nursing", default: false
    t.date "due_date"
    t.boolean "smoking", default: false
    t.integer "smoking_frequency"
    t.boolean "alcohol", default: false
    t.integer "alcohol_frequency"
    t.text "other_medical_info"
    t.boolean "teeth_pain", default: false
    t.boolean "teeth_sensitivity", default: false
    t.boolean "bleeding", default: false
    t.boolean "unpleasant_taste", default: false
    t.boolean "food_trap", default: false
    t.boolean "mouth_ulcers", default: false
    t.boolean "grinding_teeth", default: false
    t.boolean "stained_teeth", default: false
    t.boolean "uneven_teeth", default: false
    t.boolean "black_filling", default: false
    t.boolean "cracked_teeth", default: false
    t.boolean "missing_teeth", default: false
    t.boolean "crooked_teeth", default: false
    t.boolean "uncomfortable_dentures", default: false
    t.boolean "bad_breath", default: false
    t.text "other_smile_info"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_medical_forms_on_patient_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "note"
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_notes_on_booking_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "dob"
    t.string "street"
    t.string "city"
    t.string "postcode"
    t.string "sex"
    t.string "communication"
    t.date "last_visit"
    t.string "gp"
    t.string "gp_street"
    t.string "gp_city"
    t.string "gp_postcode"
    t.string "gp_tel"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.bigint "treatment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["treatment_id"], name: "index_payments_on_treatment_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.string "procedure"
    t.string "justification"
    t.integer "price_cents", default: 0, null: false
    t.bigint "treatment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["treatment_id"], name: "index_procedures_on_treatment_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile"
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.bigint "doctor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.boolean "public", default: false
    t.index ["doctor_id"], name: "index_services_on_doctor_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.string "name"
    t.text "recommendations"
    t.text "discussion"
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_treatments_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "profile_type"
    t.bigint "profile_id"
    t.boolean "doctor", default: false
    t.boolean "admin", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile_type_and_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "booking_services", "bookings"
  add_foreign_key "booking_services", "services"
  add_foreign_key "bookings", "doctors"
  add_foreign_key "bookings", "patients"
  add_foreign_key "bookings", "treatments"
  add_foreign_key "medical_forms", "patients"
  add_foreign_key "notes", "bookings"
  add_foreign_key "payments", "treatments"
  add_foreign_key "procedures", "treatments"
  add_foreign_key "services", "doctors"
  add_foreign_key "treatments", "patients"
end
