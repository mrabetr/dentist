class TestMailer < ApplicationMailer
  default from: 'contact@appointmentsapp.com'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'contact@appointmentsapp.com',
      from: 'contact@appointmentsapp.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end
