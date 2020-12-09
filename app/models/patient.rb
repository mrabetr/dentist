class Patient < ApplicationRecord
  has_one :user, as: :profile
  has_many :bookings, dependent: :destroy
  has_many :doctors, through: :bookings
  # accepts_nested_attributes_for :user

  def name
    first_name = self.user.first_name
    last_name = self.user.last_name
    "#{first_name} #{last_name}"
  end
end
