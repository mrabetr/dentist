class TestMailer < ApplicationMailer
  default from: 'contact@clinic-app.com'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'contact@clinic-app.com',
      from: 'contact@clinic-app.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end