# frozen_string_literal: true

module Users
  class PrivateApiKeysController < ApplicationController
    skip_before_action :redirect_if_inactive_subscription
    before_action :authenticate_user!
    def update
      if current_user.rotate_api_key
        redirect_to edit_user_registration_path, notice: "API Updated"
      else
        redirect_to edit_user_registration_path,
                    alert: "There was an error: #{current_user.errors.full_messages.to_sentence}"
      end
    end
  end
end
