class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

  has_many :links, dependent: :destroy
  has_encrypted :private_api_key
  blind_index :private_api_key
  validates :private_api_key, uniqueness: true, allow_blank: true

  before_create :set_private_api_key

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    "http://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  protected

  def password_required?
    confirmed? ? super : false
  end

  private

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end
