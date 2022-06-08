class Link < ApplicationRecord
  validates :url, presence: true, url: true
  validates :name, presence: true
end
