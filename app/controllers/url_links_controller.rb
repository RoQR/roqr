class UrlLinksController < ApplicationController
  include LinkDataConcern

  private

  def link_data_params
    url_link_params
  end

  def url_link_params
    params.require(:url_link).permit(:id, :url, links_attributes: [:id, :user_id, :name, :dynamic])
  end
end
