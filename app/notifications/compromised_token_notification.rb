# frozen_string_literal: true

class CompromisedTokenNotification < Noticed::Base
  include ActionView::Helpers::UrlHelper
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"

  param :url

  def message
    "Our secret scanning partner GitHub notified us that your API key might have been committed to one of " \
    "#{link_to('their repositories', params[:url],
               class: 'underline dark:no-underline dark:text-yellow-300')}. To ensure the safety of your account, we have " \
    "automatically rotated your API key.".html_safe
  end

  def icon
    "shield-exclamation"
  end
end
