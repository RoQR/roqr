PaddlePay.configure do |config|
  config.environment = :sandbox
  config.vendor_id = ENV["PADDLE_VENDOR_ID"]
  config.vendor_auth_code = ENV["PADDLE_VENDOR_AUTH_CODE"]
end
