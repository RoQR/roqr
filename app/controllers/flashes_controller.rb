class FlashesController < ApplicationController
  def create
    render turbo_stream: turbo_stream.append("flash_messages",
                                             render_to_string(FlashComponent.new(type: flash_params[:type],
                                                                                 data: flash_params[:data].to_h)))
  end

  private

  def flash_params
    params.require(:flash).permit(:type, data: [:title, :body, :timeout, :countdown, { action: %i[name method url] }])
  end
end
