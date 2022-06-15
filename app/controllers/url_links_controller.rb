class UrlLinksController < ApplicationController
  include LinkDataConcern

  private

    # Only allow a list of trusted parameters through.
    def url_link_params
      params.require(:url_link).permit(:id, :url, links_attributes: [:id, :user_id, :name, :dynamic])
    end
end
