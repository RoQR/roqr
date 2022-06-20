class Request < ApplicationRecord
  belongs_to :user

  enum method: [:get, :post, :put, :patch, :delete], _suffix: true

  validates :method, :requestable_type, :user, presence: true
  validates :requestable_type, inclusion: { in: %w(Link User) }
end