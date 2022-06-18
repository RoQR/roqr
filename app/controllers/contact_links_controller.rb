class ContactLinksController < ApplicationController
  include LinkDataConcern

  private

  def link_data_params
    contact_link_params
  end

  # Only allow a list of trusted parameters through.
  def contact_link_params
    params.require(:contact_link).permit(:id, :first_name, :last_name, :phone, :email, :website, :company, :title, :address, :birthday, :note, links_attributes: [:id, :user_id, :name, :dynamic])
  end
end
