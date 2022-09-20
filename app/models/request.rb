# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user

  enum method: %i[get post put patch delete], _suffix: true

  validates :method, :requestable_type, :user, presence: true
  validates :requestable_type, inclusion: { in: %w[Link User] }
end
