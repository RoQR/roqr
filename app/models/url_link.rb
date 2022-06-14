class UrlLink < ApplicationRecord
  validates :url, presence: true
  has_one :link, as: :link_data
  has_paper_trail
end
