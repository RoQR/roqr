class Api::V0::UsersController < Api::V0::BaseController
  load_and_authorize_resource

  def show
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render :show, status: :ok
  end 
  
  private

    def user_params
      params.require(:user).permit(:id, :name, :email)
    end
end
