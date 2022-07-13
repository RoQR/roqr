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

Stripe.plan :monthly1k do |plan|
  plan.name = 'Monthly billing - 1,000 scans / month'
  plan.amount = 900
  plan.interval = 'month'
end

Stripe.plan :monthly10k do |plan|
  plan.name = 'Monthly billing - 10,000 scans / month'
  plan.amount = 1900
  plan.interval = 'month'
end

Stripe.plan :monthly20k do |plan|
  plan.name = 'Monthly billing - 20,000 scans / month'
  plan.amount = 2900
  plan.interval = 'month'
end

Stripe.plan :monthly50k do |plan|
  plan.name = 'Monthly billing - 50,000 scans / month'
  plan.amount = 4900
  plan.interval = 'month'
end

Stripe.plan :monthly100k do |plan|
  plan.name = 'Monthly billing - 100,000 scans / month'
  plan.amount = 6900
  plan.interval = 'month'
end

Stripe.plan :monthly200k do |plan|
  plan.name = 'Monthly billing - 200,000 scans / month'
  plan.amount = 8900
  plan.interval = 'month'
end

Stripe.plan :monthly500k do |plan|
  plan.name = 'Monthly billing - 500,000 scans / month'
  plan.amount = 12_900
  plan.interval = 'month'
end

Stripe.plan :monthly1m do |plan|
  plan.name = 'Monthly billing - 1,000,000 scans / month'
  plan.amount = 16_900
  plan.interval = 'month'
end

Stripe.plan :yearly1k do |plan|
  plan.name = 'Yearly billing - 1,000 scans / month'
  plan.amount = 9000
  plan.interval = 'year'
end

Stripe.plan :yearly10k do |plan|
  plan.name = 'Yearly billing - 10,000 scans / month'
  plan.amount = 19_000
  plan.interval = 'year'
end

Stripe.plan :yearly20k do |plan|
  plan.name = 'Yearly billing - 20,000 scans / month'
  plan.amount = 29_000
  plan.interval = 'year'
end

Stripe.plan :yearly50k do |plan|
  plan.name = 'Yearly billing - 50,000 scans / month'
  plan.amount = 49_000
  plan.interval = 'year'
end

Stripe.plan :yearly100k do |plan|
  plan.name = 'Yearly billing - 100,000 scans / month'
  plan.amount = 69_000
  plan.interval = 'year'
end

Stripe.plan :yearly200k do |plan|
  plan.name = 'Yearly billing - 200,000 scans / month'
  plan.amount = 89_000
  plan.interval = 'year'
end

Stripe.plan :yearly500k do |plan|
  plan.name = 'Yearly billing - 500,000 scans / month'
  plan.amount = 129_000
  plan.interval = 'year'
end

Stripe.plan :yearly1m do |plan|
  plan.name = 'Yearly billing - 1,000,000 scans / month'
  plan.amount = 169_000
  plan.interval = 'year'
end
