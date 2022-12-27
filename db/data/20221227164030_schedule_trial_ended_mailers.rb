# frozen_string_literal: true

class ScheduleTrialEndedMailers < ActiveRecord::Migration[7.0]
  def up
    Organization.all.each do |o|
      if o.trial_ends_at.future?
        SubscriptionMailer.with(user: o.users.first).delay(run_at: o.trial_ends_at).trial_ended
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
