# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Link, user: user
    can :read, Event, link: {user: user}
    can :manage, user
  end
end
