if defined?(Resend)
  Resend.api_key = Rails.application.credentials.resend_api_key
end
