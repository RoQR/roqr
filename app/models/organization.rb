class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :styles, dependent: :destroy

  def email
    billing_email
  end
end
