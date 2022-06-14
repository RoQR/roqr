class Link < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :events, dependent: :destroy
  belongs_to :link_data, polymorphic: true, optional: true
  accepts_nested_attributes_for :link_data
  has_paper_trail

  def build_link_data(params)
    self.link_data = link_data_type.constantize.new(params)
  end
end

