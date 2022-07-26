# To deliver this notification:
#
# InvitedUserAcceptedPing.with(post: @post).deliver_later(current_user)
# InvitedUserAcceptedPing.with(post: @post).deliver(current_user)

class InvitedUserAcceptedPing < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :user

  # Define helper methods to make rendering easier.
  #
  def message
    "#{params[:user].name} accepted your invitation"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
