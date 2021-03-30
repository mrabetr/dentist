class TwilioSms
  attr_reader :from, :to, :message

  def initialize(attributes = {})
    # If from: is not given then it will use my twilio number
    @from = attributes[:from].first(11) || ENV['TWILIO_PHONE_NUMBER']
    @to = Phonelib.parse(attributes[:to]).full_e164
    @message = attributes[:message]
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create(
      from: @from,
      to: @to,
      body: @message
    )
  end
end

# If from: is not given then it will use my twilio number
# message = TwilioSms.new(from: 'Dr Mrabet', to: '+447769691379', message: 'hello mate')
# message.call
