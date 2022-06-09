class Link < ApplicationRecord
  include Linkable

  validates :name, presence: true
  validates :url, presence: true, url: true
end

