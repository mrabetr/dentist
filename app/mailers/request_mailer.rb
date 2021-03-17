class RequestMailer < ApplicationMailer
  def request_notification
    mail(to: 'mrabetr@hotmail.com', subject: 'Someone sent a new request!')
  end
end
