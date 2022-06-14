# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, link: {user: user}
    can :read, Link, user: user
    can :manage, Link, user: user 
    can :manage, UrlLink
    can :manage, user
  end
end
