class Organization < ApplicationRecord
  has_many :users
  has_many :links, dependent: :destroy
end
