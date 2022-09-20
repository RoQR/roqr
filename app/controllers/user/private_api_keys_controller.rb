# frozen_string_literal: true

module User
  class PrivateApiKeysController < ApplicationController
    before_action :authenticate_user!
    def update
      if current_user.update(private_api_key: SecureRandom.hex)
        redirect_to settings_developer_path, success: 'API key updated'
      else
        redirect_to settings_developer_path,
                    warn: "There was an error: #{current_user.errors.full_messages.to_sentence}"
      end
    end
  end
end
