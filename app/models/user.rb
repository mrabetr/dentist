class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :profile, polymorphic: true, optional: true, dependent: :destroy

  TITLE = ["Mrs.", "Mr.", "Miss.", "Ms.", "Dr.", "Mlle."]

  before_create :default_profile
  def default_profile
    self.profile = Patient.create
  end

  def doctor_profile!
    self.doctor = true
    patient = self.profile
    self.profile = Doctor.create
    self.save
    patient.destroy
  end

  def admin_profile!
    self.admin = true
    patient = self.profile
    self.profile = Admin.create
    self.save
    patient.destroy
  end

  # Uncomment below for manually getting the token and send on email with the link:
  # https://designdentalclinic/users/password/edit?reset_password_token=#{raw}
  # def run_reset_password_token
  #   raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

  #   self.reset_password_token   = enc
  #   self.reset_password_sent_at = Time.now.utc
  #   save(validate: false)
  #   raw
  # end
end
