class MedicalForm < ApplicationRecord
  belongs_to :patient

  after_commit :send_email, on: :create

  def send_email
    RequestMailer.new_form_notification.deliver!
  end
end
