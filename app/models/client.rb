class Client < ApplicationRecord
  has_one :user, as: :profile, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :providers, through: :bookings
  has_many :notes, through: :bookings
  has_many_attached :images

  include PgSearch::Model
  pg_search_scope :client_search, # name a method 'client_search'
    against: [:sex, :city],       # specify which columns I am searching
    associated_against: {         # search in an associated table
      user: [:first_name, :last_name, :email]
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

  def add_images=(attachables)
    images.attach(attachables)
  end
end
