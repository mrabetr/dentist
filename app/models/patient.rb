class Patient < ApplicationRecord
  has_one :user, as: :profile, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :doctors, through: :bookings
  has_many :notes, through: :bookings
  has_many :medical_forms, dependent: :destroy
  has_many :treatments, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :patient_search, # name a method 'patient_search'
    against: [:sex, :city],       # specify which columns I am searching
    associated_against: {         # search in an associated table
      user: [:first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }   # full search text -> tsearch
    }

  def name
    "#{user.first_name} #{user.last_name}"
  end

  def short_name
    "#{user.first_name.first}. #{user.last_name}"
  end

  def name_email
    "#{user.first_name} #{user.last_name} - #{user.email}"
  end
end
