# frozen_string_literal: true

class Notification < ApplicationRecord
  after_create_commit :update_recipients
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  def update_recipients
    broadcast_replace_later_to(
      recipient,
      :notifications,
      target: 'notifications-container',
      partial: 'notifications/indicator',
      locals: {
        user: recipient
      }
    )
  end
end
