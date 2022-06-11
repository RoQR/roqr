module UsersHelper
  def user_gravatar(user)
    email = user&.email || "test@example.com"
    name = user&.name || "Test"
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: name, class: "h-8 w-8 rounded-full")
  end
end
