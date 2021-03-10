class Patient < ApplicationRecord
  has_one :user, as: :profile, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :doctors, through: :bookings
  has_many :notes, through: :bookings
  has_many :medical_forms, dependent: :destroy
  has_many :treatments, dependent: :destroy

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
