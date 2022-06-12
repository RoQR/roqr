class Link < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true

  belongs_to :user
  has_many :events, dependent: :destroy
end

