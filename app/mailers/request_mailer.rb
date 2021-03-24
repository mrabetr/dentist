class RequestMailer < ApplicationMailer
  def request_notification
    mail(to: 'requests@designdentalclinic.com', subject: 'Someone sent a new request!')
  end
end
