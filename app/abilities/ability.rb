# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, link: {user: user}
    can :read, Link, user: user
    can :create, [EmailLink, TelephoneLink, UrlLink, WifiLink] if user.confirmed?
    can :manage, Link, user: user if user.confirmed?
    can :manage, [EmailLink, UrlLink, TelephoneLink, WifiLink], links: {user: user}
    can :manage, user
  end
end
