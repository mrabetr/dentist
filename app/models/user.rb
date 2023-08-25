class User < ApplicationRecord
  # Virtual attribute to skip password validation while saving guest customer
  attr_accessor :skip_password_validation

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :profile, polymorphic: true, optional: true, dependent: :destroy
  belongs_to :parent, polymorphic: true, optional: true
  has_many :users, as: :parent

  validates :mobile, phone: true, allow_blank: true
  validates_uniqueness_of :first_name, scope: [:email]

  TITLE = ["Mrs.", "Mr.", "Miss.", "Ms.", "Dr.", "Mlle."]

  before_create :default_profile
  def default_profile
    self.profile = Client.create
  end

  def provider_profile!
    self.provider = true
    client = self.profile
    self.profile = Provider.create
    self.save
    client.destroy
  end

  def admin_profile!
    self.admin = true
    client = self.profile
    self.profile = Admin.create
    self.save
    client.destroy
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

  private

  # Skipping email uniqueness validation for children users
  # It also skips email format validation, which is irrelevant when an existing email has been validated already
  def will_save_change_to_email?
    return false unless User.exists?(email: email, first_name: first_name)

    super
  end

  def password_required?
    return false if skip_password_validation

    super
  end
end
