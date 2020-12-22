class Doctor < ApplicationRecord
  has_one :user, as: :profile
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :patients, through: :bookings
  # accepts_nested_attributes_for :user

  def name
    "#{user.first_name} #{user.last_name}"
  end

  def short_name
    "#{user.first_name.first}. #{user.last_name}"
  end
end
