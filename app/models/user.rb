class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile, polymorphic: true, optional: true

  before_create :default_profile
  def default_profile
    self.profile = Patient.create
  end

  def doctor_profile!
    self.doctor = true
    self.profile = Doctor.create
    self.save
  end

  def admin_profile!
    self.admin = true
    self.profile = Admin.create
    self.save
  end
end
