class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[github google_oauth2]

  belongs_to :organization
  accepts_nested_attributes_for :organization
  has_encrypted :private_api_key
  blind_index :private_api_key
  validates :private_api_key, uniqueness: true, allow_blank: true
  before_create :set_private_api_key
  has_many :requests, dependent: :destroy
  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id

  before_validation :maybe_create_org

  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.organization = Organization.new
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
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
    self.private_api_key = SecureRandom.hex if private_api_key.nil?
  end
end
