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

ActiveRecord::Schema.define(version: 2020_12_29_111822) do

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
    t.index ["doctor_id"], name: "index_bookings_on_doctor_id"
    t.index ["patient_id"], name: "index_bookings_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_type", "profile_id"], name: "index_users_on_profile_type_and_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "booking_services", "bookings"
  add_foreign_key "booking_services", "services"
  add_foreign_key "bookings", "doctors"
  add_foreign_key "bookings", "patients"
  add_foreign_key "notes", "bookings"
  add_foreign_key "services", "doctors"
end
