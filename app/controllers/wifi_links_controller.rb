class WifiLinksController < ApplicationController
  include LinkDataConcern

  private

  def link_data_params
    wifi_link_params
  end

  def wifi_link_params
    params.require(:wifi_link).permit(:id, :ssid, :password, :hidden, :protocol, links_attributes: [:id, :user_id, :name, :dynamic])
  end
end
