# frozen_string_literal: true

class BackfillIpMasking < ActiveRecord::Migration[7.0]
  def up
    Ahoy::Visit.find_each do |visit|
      visit.update_column :ip, Ahoy.mask_ip(visit.ip)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
