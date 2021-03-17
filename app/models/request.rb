class Request < ApplicationRecord
  validates :mobile, format: { with: /\A(0|(\+|00)[1-9]\d{1,2}[\s-]?)[1-9]\d{8,}\z/, message: "bad format" }

  after_commit :send_email, on: :create

  def send_email
    RequestMailer.request_notification.deliver!
  end
end
