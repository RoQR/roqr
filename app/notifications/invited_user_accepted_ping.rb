class InvitedUserAcceptedPing < Noticed::Base
  include ActionView::Helpers::UrlHelper
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"

  param :user

  def message
    link_to "#{params[:user].name} accepted your invitation", user_path(params[:user].id)
  end
end
