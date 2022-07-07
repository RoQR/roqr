class MakeDynamicLinksDefault < ActiveRecord::Migration[7.0]
  def up
    change_column_default :links, :dynamic, true
  end

  def down
    change_column_default :links, :dynamic, false
  end
end
