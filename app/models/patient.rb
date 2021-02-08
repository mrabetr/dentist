class Patient < ApplicationRecord
  has_one :user, as: :profile
  has_many :bookings, dependent: :destroy
  has_many :doctors, through: :bookings
  has_many :notes, through: :bookings
  has_many :forms, dependent: :destroy

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
