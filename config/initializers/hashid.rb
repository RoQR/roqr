# frozen_string_literal: true

Dotenv.require_keys("HASHID_SALT")
Hashid::Rails.configure do |config|
  config.salt = ENV.fetch("HASHID_SALT")
end
