# frozen_string_literal: true

class Ability
  include CanCan::Ability
  LINK_TYPES = [ContactLink, EmailLink, SmsLink, TelephoneLink, UrlLink, WifiLink].freeze

  def initialize(user)
    user ||= User.new(role: "viewer")

    viewer_abilities(user)
    return unless %w[editor administrator].include?(user.role)

    editor_abilities(user)
    return unless user.role == "administrator"

    admin_abilities(user)
  end

  private

  def viewer_abilities(user)
    can :show, PublicPage
    can %i[challenge scan], Link
    can :read, Scan, link: { organization: user.organization, archived_at: nil }
    can :read, Notification, recipient_type: "User", recipient_id: user.id
    can :read, [Style, Link, Request], organization: user.organization
    can :read, User, organization: user.organization
    can :download, Link, organization: user.organization
    can :manage, user
    can :create, Organization
  end

  def editor_abilities(user)
    can :manage, PublicPage, organization: user.organization
    can %i[read create update], [Style, Link], organization: user.organization
    can :remove_password, Link, organization: user.organization
    can :archive, Link, organization: user.organization, archived_at: nil
    can %i[unarchive confirm_destroy destroy], Link do |link|
      link.organization == user.organization && !link.archived_at.nil?
    end
    can :destroy, Style, organization: user.organization
    can :create, LINK_TYPES
    can :manage, LINK_TYPES, link: { organization: user.organization }
  end

  def admin_abilities(user)
    can :invite, User
    can :manage, User, organization: user.organization
    can :manage, Organization, id: user.organization&.id
    can :manage, Subscription, organization: user.organization
    cannot :new, Subscription, organization: user.organization if user.organization.subscribed?
    cannot :edit, Subscription, organization: user.organization if user.organization.subscription_cancelled?
  end
end
