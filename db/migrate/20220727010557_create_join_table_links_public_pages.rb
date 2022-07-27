class CreateJoinTableLinksPublicPages < ActiveRecord::Migration[7.0]
  def change
    create_join_table :links, :public_pages, column_options: { type: :uuid } do |t|
      t.index %i[link_id public_page_id]
    end
  end
end
