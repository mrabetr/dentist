class NotificationMailer < ApplicationMailer
  def request_notification
    mail(to: 'requests@appointmentsapp.com', subject: 'Someone sent a new request!')
  end

  def request_acknowledgement
    @request = params[:request]

    mail(
      to:       @request.email,
      cc:       "requests@appointmentsapp.com",
      subject:  "Thanks for your request!"
    )
  end

  def new_form_notification
    mail(to: 'requests@appointmentsapp.com', subject: 'New medical form!')
  end
end
