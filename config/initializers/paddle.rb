# frozen_string_literal: true

PaddlePay.configure do |config|
  config.environment = :sandbox
  config.vendor_id = ENV.fetch('PADDLE_VENDOR_ID', nil)
  config.vendor_auth_code = ENV.fetch('PADDLE_VENDOR_AUTH_CODE', nil)
end
