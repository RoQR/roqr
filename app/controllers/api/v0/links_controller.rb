class Api::V0::LinksController < Api::V0::BaseController
  before_action :set_link, only: [:show, :update, :destroy] 

  def index
    @links = @user.links
  end

  def show
  end

  def create
    @link = @user.links.build(link_params)
    if @link.save
      render :show, status: :created
    else
      render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      render :show, status: :ok
    else
      render json: { message: @link.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    render :show, status: :ok
  end 
  
  private

    def set_link
      @link = link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:id, :name, :user_id, :dynamic)
    end
end
