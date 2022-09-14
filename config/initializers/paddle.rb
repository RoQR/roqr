PaddlePay.configure do |config|
  config.environment = :sandbox
  config.vendor_id = Rails.application.credentials.dig(:paddle, :vendor_id)
  config.vendor_auth_code = Rails.application.credentials.dig(:paddle, :vendor_auth_code)
end
