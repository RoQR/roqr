# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to settings_organization_path, notice: 'Your organization has been updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def confirm_destroy
    render TurboModalComponent.new(title: 'Delete account').with_content(render_to_string(partial: 'organizations/confirm_destroy'))
  end

  private

  # Only allow a list of trusted parameters through.
  def organization_params
    params.require(:organization).permit(:name, :billing_email)
  end
end
