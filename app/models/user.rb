class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile, polymorphic: true, optional: true

  # def role
  #   profile.profile_type.downcase # 'admin', 'doctor' or 'patient'
  # end
end
