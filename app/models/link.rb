class Link < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, url: true
end

