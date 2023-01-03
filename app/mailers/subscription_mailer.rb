class SubscriptionMailer < ApplicationMailer
  def trial_ended
    @user = params[:user]
    return unless @user.confirmed?

    mail(to: @user.email, subject: "Your RoQR trial has ended")
  end
end
