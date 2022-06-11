class Link < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, url: true

  belongs_to :user
  has_many :events, dependent: :destroy
end

