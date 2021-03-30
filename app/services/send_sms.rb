# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'

account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
# account_sid = 'AC5caceda415e199db4b09fd00936cf26c'
# auth_token = '9ebf5de24d1975ceb4506df53b6650a3'
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+447723354409' # Your Twilio number
to = '+447769691379' # Your mobile phone number

client.messages.create(
  from: from,
  to: to,
  body: "Hey friend! Design Dental Clinic"
)

# require_relative 'twilio_service'
# message = TwilioService.new
# message.send_sms
