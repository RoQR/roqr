class EmailLinksController < ApplicationController
  include LinkDataConcern

  private

    # Only allow a list of trusted parameters through.
    def email_link_params
      params.require(:email_link).permit(:id, :email_address, :subject, :body, links_attributes: [:id, :user_id, :name])
    end
end
