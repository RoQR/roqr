# This file contains descriptions of all your stripe plans

# Example
# Stripe::Plans::PRIMO #=> 'primo'

# Stripe.plan :primo do |plan|
#   # plan name as it will appear on credit card statements
#   plan.name = 'Acme as a service PRIMO'
#
#   # amount in cents. This is 6.99
#   plan.amount = 699
#
#   # currency to use for the plan (default 'usd')
#   plan.currency = 'usd'
#
#   # interval must be either 'day', 'week', 'month' or 'year'
#   plan.interval = 'month'
#
#   # only bill once every three months (default 1)
#   plan.interval_count = 3
#
#   # number of days before charging customer's card (default 0)
#   plan.trial_period_days = 30
# end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.

Stripe.plan :monthly do |plan|
  plan.name = 'Monthly'
  plan.interval = 'month'
  plan.trial_period_days = 30
  plan.billing_scheme = 'tiered'
  plan.tiers_mode = 'volume'
  plan.tiers = [
    {
      flat_amount: 900,
      up_to: 1000
    },
    {
      flat_amount: 1900,
      up_to: 10_000
    },
    {
      flat_amount: 2900,
      up_to: 20_000
    },
    {
      flat_amount: 4900,
      up_to: 50_000
    },
    {
      flat_amount: 6900,
      up_to: 100_000
    },
    {
      flat_amount: 8900,
      up_to: 200_000
    },
    {
      flat_amount: 12_900,
      up_to: 500_000
    },
    {
      flat_amount: 16_900,
      up_to: 'inf'
    }
  ]
end

Stripe.plan :yearly do |plan|
  plan.name = 'Yearly'
  plan.interval = 'year'
  plan.billing_scheme = 'tiered'
  plan.tiers_mode = 'volume'
  plan.tiers = [
    {
      flat_amount: 9000,
      up_to: 1000
    },
    {
      flat_amount: 19_000,
      up_to: 10_000
    },
    {
      flat_amount: 29_000,
      up_to: 20_000
    },
    {
      flat_amount: 49_000,
      up_to: 50_000
    },
    {
      flat_amount: 69_000,
      up_to: 100_000
    },
    {
      flat_amount: 89_000,
      up_to: 200_000
    },
    {
      flat_amount: 129_000,
      up_to: 500_000
    },
    {
      flat_amount: 169_000,
      up_to: 'inf'
    }
  ]
end
