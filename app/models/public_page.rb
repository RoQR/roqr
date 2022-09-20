# frozen_string_literal: true

class PublicPage < ApplicationRecord
  belongs_to :organization
  has_and_belongs_to_many :links
  has_many :scans, through: :links
end
