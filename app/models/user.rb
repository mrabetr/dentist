class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile, polymorphic: true, optional: true

  before_create :default_profile
  def default_profile
    # patient = Patient.create
    self.profile = Patient.create
  end

  before_update :doctor_profile
  def doctor_profile
    self.profile = Doctor.create if self.doctor
    # if self.doctor
    #   doctor = Doctor.create
    #   self.profile = doctor
    # end
  end

  # def role
  #   profile.profile_type.downcase # 'admin', 'doctor' or 'patient'
  # end
end
