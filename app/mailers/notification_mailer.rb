class NotificationMailer < ApplicationMailer
  def request_notification
    mail(to: 'requests@designdentalclinic.com', subject: 'Someone sent a new request!')
  end

  def new_form_notification
    mail(to: 'requests@designdentalclinic.com', subject: 'New medical form!')
  end
end
