class AddUserPermissions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :can_create_links, true
    add_column :users, :can_edit_links, :boolean, default: true
    add_column :users, :can_delete_links, :boolean, default: true
    add_column :users, :can_invite_users, :boolean, default: true
    add_column :users, :can_edit_users, :boolean, default: true
    add_column :users, :can_delete_users, :boolean, default: true
    add_column :users, :can_edit_organization, :boolean, default: true
    add_column :users, :can_delete_organization, :boolean, default: true
  end
end
