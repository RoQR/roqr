# frozen_string_literal: true

Dotenv.require_keys("PADDLE_VENDOR_ID", "PADDLE_VENDOR_AUTH_CODE")

PaddlePay.configure do |config|
  config.environment = if Rails.env.production?
                         :production
                       else
                         :sandbox
                       end
  config.vendor_id = ENV.fetch("PADDLE_VENDOR_ID")
  config.vendor_auth_code = ENV.fetch("PADDLE_VENDOR_AUTH_CODE")
end
