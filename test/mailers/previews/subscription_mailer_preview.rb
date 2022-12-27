require "factory_bot_rails"
# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  include FactoryBot::Syntax::Methods
  def trial_ended
    SubscriptionMailer.with(user: create(:user)).trial_ended
  end
end
