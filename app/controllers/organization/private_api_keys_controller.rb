class Organization::PrivateApiKeysController < ApplicationController
  before_action :authenticate_user!

  def update
    debugger
    if current_user.organization.update(private_api_key: SecureRandom.hex)
      redirect_to edit_user_path(current_user), success: "API key updated"
    else
      redirect_to edit_user_path(current_user), warn: "There was an error: #{current_user.errors.full_messages.to_sentence}"
    end
  end
end
