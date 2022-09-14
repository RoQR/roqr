class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resources

  def profile; end

  def organization; end

  def settings; end

  private

  def load_resources
    @user = current_user
    @organization = current_user.organization
  end
end
