class Patient < ApplicationRecord
  has_one :user, as: :profile
  has_many :bookings, dependent: :destroy
  has_many :doctors, through: :bookings
  has_many :notes, through: :bookings

  def name
    "#{user.first_name} #{user.last_name}"
  end

  def short_name
    "#{user.first_name.first}. #{user.last_name}"
  end
end
