class Doctor < ApplicationRecord
  has_one user, as: :profile
  # accepts_nested_attributes_for :user
end
