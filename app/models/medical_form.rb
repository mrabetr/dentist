class MedicalForm < ApplicationRecord
  belongs_to :patient

  after_commit :send_email, on: :create

  def send_email
    NotificationMailer.new_form_notification.deliver!
  rescue Postmark::InactiveRecipientError => e
    # Log the error so that you can check it out later
    Rails.logger.error("Error sending email: #{e.message}")
  end
end
