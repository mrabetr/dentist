class Request < ApplicationRecord
  # Virtual attribute for invisible_captcha to work
  attr_accessor :remote_ip

  validates :mobile, format: { with: /\A(0|(\+|00)[1-9]\d{1,2}[\s-]?)[1-9]\d{8,}\z/, message: "bad format" }

  # after_commit :send_email, on: :create
  after_commit :send_acknowledgement, on: :create

  def send_email
    NotificationMailer.request_notification.deliver!
  end

  def send_acknowledgement
    NotificationMailer.with(request: self).request_acknowledgement.deliver!
  end
end
