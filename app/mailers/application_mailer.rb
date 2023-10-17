class ApplicationMailer < ActionMailer::Base
  CONTACT_EMAIL = ENV['CONTACT_EMAIL'] || 'contact@designdentalclinic.com'

  default from: CONTACT_EMAIL
  layout 'mailer'
end
