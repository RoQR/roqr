# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :masqueradable, :omniauthable, omniauth_providers: %i[github google_oauth2]

  enum role: { viewer: "viewer", editor: "editor", administrator: "administrator" }
  belongs_to :organization
  validates :private_api_key, uniqueness: true, allow_blank: true
  validates :role, inclusion: { in: roles.keys }
  before_create :set_private_api_key
  has_many :requests, dependent: :destroy
  has_many :notifications, as: :recipient
  has_encrypted :private_api_key
  blind_index :private_api_key

  validates :password, presence: true, length: { in: Devise.password_length }, format: { with: PASSWORD_FORMAT },
                       confirmation: true, on: :create

  validates :password, allow_nil: true, length: { in: Devise.password_length }, format: { with: PASSWORD_FORMAT },
                       confirmation: true, on: :update

  before_validation :maybe_create_org

  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.assign_attributes(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        organization: Organization.new
      )
      user.skip_confirmation!
    end
  end

  def display_name
    name || email
  end

  private

  def password_required?
    confirmed? ? super : false
  end

  def maybe_create_org
    self.organization = Organization.new if organization.nil?
  end

  def set_private_api_key
    self.private_api_key = "roqr_#{SecureRandom.hex}" if private_api_key.nil?
  end
end
