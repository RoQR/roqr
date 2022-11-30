# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    add_breadcrumb "Organization settings", settings_organization_path
    add_breadcrumb @user.name, user_path(@user)
  end

  def edit
    add_breadcrumb "Organization settings", settings_organization_path
    add_breadcrumb @user.name, user_path(@user)
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_url(@user), notice: "Successfully created account." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user.update(user_params)
      if @user == current_user
        redirect_to settings_profile_path
      else
        redirect_to user_path(@user)
      end
    else
      flash.now[:error] = @user.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to settings_organization_path, notice: "#{@user.display_name}'s account has been deleted" }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
