class AddAdditionalColumnsToCustomDomain < ActiveRecord::Migration[7.0]
  def change
    # TODO: change this to an enum column once we have a good sense of possible statuses
    add_column :custom_domains, :status, :string, nil: false, default: "Submitted"
    add_column :custom_domains, :dns_validation_hostname, :string
    add_column :custom_domains, :dns_validation_target, :string
    add_column :custom_domains, :ipv4_target, :string
    add_column :custom_domains, :ipv6_target, :string
  end
end
