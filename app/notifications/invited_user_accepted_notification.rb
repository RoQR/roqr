# frozen_string_literal: true

class InvitedUserAcceptedNotification < Noticed::Base
  include ActionView::Helpers::UrlHelper
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"

  param :user_name

  def message
    link_to "#{params[:user_name]} accepted your invitation", settings_organization_path
  end

  def icon
    'user-circle'
  end
end
