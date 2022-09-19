# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user = user ||= User.new
    can :show, PublicPage
    can :scan, Link
    can :read, Scan, link: { organization: user.organization, deleted_at: nil }
    can :read, Notification, recipient_type: 'User', recipient_id: user.id
    can :read, [Style, Link, Request], organization: user.organization
    can :read, User, organization: user.organization
    can :download, Link, organization: user.organization
    can :manage, user
    can :create, Organization
    return unless %w[user administrator].include?(user.role)

    can :manage, PublicPage, organization: user.organization
    can :manage, [Style, Link], organization: user.organization
    can :remove_password, Link, organization: user.organization
    can :archive, Link, organization: user.organization, deleted_at: nil
    can :confirm_destroy, Link do |link|
      link.organization == user.organization && link.deleted_at?
    end
    can :create, [ContactLink, EmailLink, SmsLink, TelephoneLink, UrlLink, WifiLink]
    can :manage, [ContactLink, EmailLink, SmsLink, UrlLink, TelephoneLink, WifiLink],
        link: { organization: user.organization }

    return unless user.role == 'administrator'

    can :invite, User
    can :manage, User, organization: user.organization
    can :manage, Organization, id: user.organization.id
  end
end
