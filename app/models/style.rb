class Style < ApplicationRecord
  DOTS_SHAPES = %w[square rounded extra-rounded dots classy classy-rounded].freeze
  CORNER_SQUARES_SHAPES = %w[square extra-rounded dot].freeze
  CORNER_DOTS_SHAPES = %w[square dot].freeze
  belongs_to :organization
  validates :name, presence: true, uniqueness: { scope: :organization_id }
end
