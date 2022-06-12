class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :links, dependent: :destroy

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    "http://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
