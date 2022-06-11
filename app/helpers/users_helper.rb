module UsersHelper
  def user_gravatar(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "h-8 w-8 rounded-full")
  end

  def current_user
    User.first || User.new
  end
end
