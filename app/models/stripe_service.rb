class StripeService
  def self.initialize_organization(organization)
    customer = create_initial_customer(organization)
    organization.stripe_customer_id = customer.id
    subscription = subscribe_to_default_plan(customer)
    organization.stripe_subscription_id = subscription.id
    organization.save
  end

  def self.update_organization(organization)
    Stripe::Customer.update(
      organization.stripe_customer_id,
      email: organization.billing_email,
      name: organization.name
    )
  end

  def self.create_initial_customer(organization)
    Stripe::Customer.create(
      email: organization.billing_email
    )
  end

  def self.subscribe_to_default_plan(customer)
    Stripe::Subscription.create(
      customer: customer.id,
      items: [{
        price: 'price_1LJGVuKEEF3z117yBoHSZZuo'
      }],
      payment_behavior: 'default_incomplete'
    )
  end
end
