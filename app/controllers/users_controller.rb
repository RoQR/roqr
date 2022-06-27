class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def edit
    @portal_session = current_user.organization.payment_processor.billing_portal
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_url(@user), notice: 'Successfully created account.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user == current_user
          format.html { redirect_to settings_profile_path, notice: 'Your acount has been updated' }
        else
          format.html { redirect_to user_path(@user), notice: "#{@user.display_name}'s acount has been updated" }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "#{@user.display_name}'s account has been deleted" }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, organization_attributes: %i[name])
  end
end
