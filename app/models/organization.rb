class Organization < ApplicationRecord
  has_many :users
  has_many :links, dependent: :destroy
  has_encrypted :private_api_key
  blind_index :private_api_key
  validates :private_api_key, uniqueness: true, allow_blank: true
  has_many :requests, dependent: :destroy

  before_create :set_private_api_key

  private

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
