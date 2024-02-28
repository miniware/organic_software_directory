Passwordless.configure do |config|
  config.default_from_address = "bot@built.organic"
  config.paranoid = true # Display email sent notice even when the resource is not found.
  config.timeout_at = lambda { 20.minutes.from_now } # How long until a token/magic link times out.
end