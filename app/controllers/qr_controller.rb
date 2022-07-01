class QrController < ApplicationController
  before_action :authenticate_user!
  def show
    @params = params.permit(:data, :format, :fill, :color)
    render inline: QrGenerator.gen(params[:data], fill: params[:fill] || '#fff', color: params[:color] || '#000')
  end
end
