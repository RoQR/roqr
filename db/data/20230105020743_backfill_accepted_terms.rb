# frozen_string_literal: true

class BackfillAcceptedTerms < ActiveRecord::Migration[7.0]
  def up
    User.all.each do |u|
      u.terms_accepted = true if u.confirmed?
      u.save(touch: false)
    end
  end

  def down
  end
end
