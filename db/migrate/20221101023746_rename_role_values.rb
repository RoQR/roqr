class RenameRoleValues < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TYPE user_role RENAME VALUE 'reader' TO 'viewer';
      ALTER TYPE user_role RENAME VALUE 'user' TO 'editor';
    SQL
  end
end
