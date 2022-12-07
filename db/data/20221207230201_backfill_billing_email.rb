# frozen_string_literal: true

class BackfillBillingEmail < ActiveRecord::Migration[7.0]
  def up
    Organization.where(billing_email: nil).each do |o|
      # Every org should have an administrator
      u = o.users.find(&:administrator?)
      o.billing_email = u.email
      o.save(touch: false)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
