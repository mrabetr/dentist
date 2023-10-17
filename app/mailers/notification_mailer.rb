class NotificationMailer < ApplicationMailer
  REQUESTS_EMAIL = ENV['REQUESTS_EMAIL'] || 'requests@designdentalclinic.com'

  def request_notification
    mail(to: REQUESTS_EMAIL, subject: 'Someone sent a new request!')
  end

  def request_acknowledgement
    @request = params[:request]

    mail(
      to:       @request.email,
      cc:       REQUESTS_EMAIL,
      subject:  "Design Dental Clinic - Thanks for your request!"
    )
  end

  def new_form_notification
    mail(to: REQUESTS_EMAIL, subject: 'New medical form!')
  end
end
