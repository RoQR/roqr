class SubscriptionMailer < ApplicationMailer
  def trial_ended
    @user = params[:user]
    mail(to: @user.email, subject: "Your RoQR trial has ended")
  end
end
