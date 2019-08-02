Nexmo.setup do |config|
  config.api_key = Rails.application.credentials.nexmo[:api_key],
  config.api_secret = Rails.application.credentials.nexmo[:api_secret],
  config.signature_secret = Rails.application.credentials.nexmo[:api_signature],
  config.application_id = Rails.application.credentials.nexmo[:application_id],
  config.private_key = Rails.application.credentials.nexmo[:private_key]
end
