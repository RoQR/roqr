class DropPublicPageTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :public_pages
    drop_join_table :links, :public_pages
  end
end
