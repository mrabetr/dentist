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
    patient = self.profile
    self.profile = Doctor.create
    patient.destroy
    self.save
  end

  def admin_profile!
    self.admin = true
    patient = self.profile
    self.profile = Admin.create
    patient.destroy
    self.save
  end
end
