Hashid::Rails.configure do |config|
  config.salt = Rails.application.credentials.dig(:hashid, :salr)
end
