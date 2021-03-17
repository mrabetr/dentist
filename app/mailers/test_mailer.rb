class TestMailer < ApplicationMailer
  default from: 'contact@designdentalclinic.com'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'contact@designdentalclinic.com',
      from: 'contact@designdentalclinic.com',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end
