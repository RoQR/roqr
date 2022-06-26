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
        format.html { redirect_to edit_user_url(@user), notice: 'Your account has been updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to new_user_session_path, notice: 'Your account has been deleted.' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, organization_attributes: %i[id name])
  end
end
