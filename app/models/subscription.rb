class Subscription < ApplicationRecord
  belongs_to :organization
  alias_attribute :subscription_id, :paddle_subscription_id
end
