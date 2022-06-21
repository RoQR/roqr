# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  def new
    super
  end

  def edit
    super
  end

  def create
    super
  end

  def update
    super
  end

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:organization_id])
  end

end
