class AddCustomDomainToLink < ActiveRecord::Migration[7.0]
  def change
    add_reference :links, :custom_domain
  end
end
