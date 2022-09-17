# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user = user ||= User.new
    can :show, PublicPage
    can :scan, Link
    can :read, Scan, link: { organization: user.organization, deleted_at: nil }
    can :read, Notification, recipient_type: 'User', recipient_id: user.id
    can :read, Request, organization: user.organization
    can :read, [Style, Link], organization: user.organization
    can :download, Link, organization: user.organization
    can :manage, user
    can :create, Organization
    can :update, Organization, id: user.organization.id if user.confirmed? && user.can_edit_organization
    can :destroy, Organization, id: user.organization.id if user.confirmed? && user.can_delete_organization

    return unless user&.organization&.on_trial_or_subscribed?

    can :create, [Style, Link], organization: user.organization if user.confirmed? && user.can_create_links
    can :update, [Style, Link], organization: user.organization if user.confirmed? && user.can_edit_links
    can :remove_password, Link, organization: user.organization if user.confirmed? && user.can_edit_links
    can :archive, Link, organization: user.organization, deleted_at: nil if user.confirmed? && user.can_delete_links
    can :confirm_destroy, Link do |link|
      link.organization == user.organization && link.deleted_at? && user.confirmed? && user.can_delete_links
    end
    can :destroy, [Style, Link], organization: user.organization if user.confirmed? && user.can_delete_links
    can :create, [ContactLink, EmailLink, SmsLink, TelephoneLink, UrlLink, WifiLink] if user.confirmed?
    can :manage, [ContactLink, EmailLink, SmsLink, UrlLink, TelephoneLink, WifiLink],
        link: { organization: user.organization }
    can :invite, User if user.can_invite_users
    can :read, User, organization: user.organization
    can :create, User, organization: user.organization if user.can_invite_users
    can :update, User, organization: user.organization if user.can_edit_users
    can :destroy, User, organization: user.organization if user.can_delete_users
    can :manage, PublicPage, organization: user.organization
  end
end
