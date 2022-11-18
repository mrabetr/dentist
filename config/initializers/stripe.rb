Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY'],
  # this secret key is found in stripe's Developers/Webhooks page
  signing_secret:  ENV['STRIPE_WEBHOOK_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = Rails.configuration.stripe[:signing_secret]

# make sure you have created StripeCheckoutSessionService class in the app/services directory
Rails.application.config.to_prepare do
  StripeEvent.configure do |events|
    events.subscribe 'checkout.session.completed', StripeCheckoutSessionService.new
  end
end
