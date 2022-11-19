# frozen_string_literal: true

Dotenv.require_keys("LOCKBOX_MASTER_KEY")
Lockbox.master_key = ENV.fetch("LOCKBOX_MASTER_KEY")
