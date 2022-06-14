module LinkDataModelConcern
  extend ActiveSupport::Concern
  included do
    has_many :links, as: :link_data, dependent: :destroy
    accepts_nested_attributes_for :links
    has_paper_trail
  end
end
