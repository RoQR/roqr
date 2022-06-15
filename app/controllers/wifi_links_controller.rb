class WifiLinksController < ApplicationController
  include LinkDataConcern

  private

    # Only allow a list of trusted parameters through.
    def wifi_link_params
      params.require(:wifi_link).permit(:id, :ssid, :password, :hidden, :protocol, links_attributes: [:id, :user_id, :name])
    end
end
