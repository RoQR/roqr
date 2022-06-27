class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to edit_organization_path(@organization), notice: 'Your organization has been updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def organization_params
    params.require(:organization).permit(:name, :billing_email)
  end
end
