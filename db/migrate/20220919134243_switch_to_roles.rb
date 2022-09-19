class SwitchToRoles < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('reader', 'user', 'administrator');
    SQL
    add_column :users, :role, :user_role, null: false, default: 'administrator'
    remove_column :users, :can_create_links
    remove_column :users, :can_edit_links
    remove_column :users, :can_delete_links
    remove_column :users, :can_invite_users
    remove_column :users, :can_edit_users
    remove_column :users, :can_delete_users
    remove_column :users, :can_edit_organization
    remove_column :users, :can_delete_organization
  end
end
