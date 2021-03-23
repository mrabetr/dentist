class RequestMailer < ApplicationMailer
  def request_notification
    mail(to: 'contact@designdentalclinic.com', subject: 'Someone sent a new request!')
  end
end
