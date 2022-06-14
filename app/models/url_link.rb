class UrlLink < ApplicationRecord
  validates :url, presence: true
  has_many :links, as: :link_data
  accepts_nested_attributes_for :links
  has_paper_trail
end
