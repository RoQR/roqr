# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, link: {organization: user.organization}
    can :read, Request, organization: user.organization
    can :read, Link, organization: user.organization
    can :manage, Link, organization: user.organization if user.confirmed?
    can :create, Organization
    can :manage, Organization, id: user.organization.id if user.confirmed?
    can :create, [ContactLink, EmailLink, SmsLink, TelephoneLink, UrlLink, WifiLink] if user.confirmed?
    can :manage, [ContactLink, EmailLink, SmsLink, UrlLink, TelephoneLink, WifiLink], link: {organization: user.organization}
    can :manage, user
  end
end
