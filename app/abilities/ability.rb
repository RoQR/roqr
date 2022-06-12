# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, link: {user: user}
    can :read, Link, user: user
    if user.confirmed?
      can :manage, Link, user: user
    end
    can :manage, user
  end
end
