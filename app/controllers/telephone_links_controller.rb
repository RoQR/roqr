class TelephoneLinksController < ApplicationController
  include LinkDataConcern

  private

    # Only allow a list of trusted parameters through.
    def telephone_link_params
      params.require(:telephone_link).permit(:id, :number, links_attributes: [:id, :user_id, :name, :dynamic])
    end
end
