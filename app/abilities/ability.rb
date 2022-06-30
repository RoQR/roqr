# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Scan, link: { organization: user.organization }
    can :read, Request, organization: user.organization
    can :read, [Style, Link], organization: user.organization
    can :create, [Style, Link], organization: user.organization if user.confirmed? && user.can_create_links
    can :update, [Style, Link], organization: user.organization if user.confirmed? && user.can_edit_links
    can :confirm_destroy, Link, organization: user.organization if user.confirmed? && user.can_delete_links
    can :destroy, [Style, Link], organization: user.organization if user.confirmed? && user.can_delete_links
    can :create, Organization
    can :update, Organization, id: user.organization.id if user.confirmed? && user.can_edit_organization
    can :destroy, Organization, id: user.organization.id if user.confirmed? && user.can_delete_organization
    can :create, [ContactLink, EmailLink, SmsLink, TelephoneLink, UrlLink, WifiLink] if user.confirmed?
    can :manage, [ContactLink, EmailLink, SmsLink, UrlLink, TelephoneLink, WifiLink],
        link: { organization: user.organization }
    can :manage, user
    can :invite, User if user.can_invite_users
    can :read, User, organization: user.organization
    can :create, User, organization: user.organization if user.can_invite_users
    can :update, User, organization: user.organization if user.can_edit_users
    can :destroy, User, organization: user.organization if user.can_delete_users
  end
end
