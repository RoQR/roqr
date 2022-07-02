class QrController < ApplicationController
  before_action :authenticate_user!
  def show
    @params = params.permit(:data, :format, :fill, :color, :position_border, :position_core)
    render inline: QrGenerator.gen(params[:data], fill: params[:fill] || '#fff', color: params[:color] || '#000',
                                                  position_border: params[:position_border] || '#000', position_core: params[:position_core] || '#000')
  end
end
