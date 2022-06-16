class Link < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :events, dependent: :destroy
  belongs_to :link_data, polymorphic: true
  has_paper_trail
  delegate :summary, :barcode_data, to: :link_data
end

