# frozen_string_literal: true

class AdminUser < ApplicationRecord
  devise :database_authenticatable
  validates :email, presence: true, email: { domain: "roqr.app" }
end
