# frozen_string_literal: true

class PopulateNewIds < ActiveRecord::Migration[7.0]
  def up
    Link.all.each do |l|
      l.contact_link_new_id = l.contact_link&.new_id
      l.email_link_new_id = l.email_link&.new_id
      l.sms_link_new_id = l.sms_link&.new_id
      l.telephone_link_new_id = l.telephone_link&.new_id
      l.url_link_new_id = l.url_link&.new_id
      l.wifi_link_new_id = l.wifi_link&.new_id
      l.organization_new_id = l.organization.new_id
      l.save
    end
    execute <<-SQL
      UPDATE links_public_pages SET link_new_id = links.new_id
      FROM links WHERE links_public_pages.link_id = links.id;
    SQL
    execute <<-SQL
      UPDATE links_public_pages SET public_page_new_id = public_pages.new_id
      FROM public_pages WHERE links_public_pages.public_page_id = public_pages.id;
    SQL
    Notification.all.each do |n|
      n.recipient_new_id = n.recipient&.new_id
      n.save
    end
    PublicPage.all.each do |p|
      p.organization_new_id = p.organization.new_id
      p.save
    end
    Request.all.each do |r|
      r.user_new_id = r.user.new_id
      r.save
    end
    Scan.all.each do |s|
      s.link_new_id = s.link.new_id
      s.save
    end
    Style.all.each do |s|
      s.organization_new_id = s.organization.new_id
      s.save
    end
    Subscription.all.each do |s|
      s.organization_new_id = s.organization.new_id
      s.save
    end
    User.all.each do |u|
      u.organization_new_id = u.organization.new_id
      u.invited_by_new_id = u.invited_by&.new_id
      u.save
    end
  end

  def down
    Link.all.each do |l|
      l.contact_link_new_id = nil
      l.email_link_new_id = nil
      l.sms_link_new_id = nil
      l.telephone_link_new_id = nil
      l.url_link_new_id = nil
      l.wifi_link_new_id = nil
      l.organization_new_id = nil
      l.save
    end
    execute <<-SQL
      UPDATE links_public_pages SET link_new_id = NULL;
    SQL
    execute <<-SQL
      UPDATE links_public_pages SET public_page_new_id = NULL;
    SQL
    Notification.all.each do |n|
      n.recipient_new_id = nil
      n.save
    end
    PublicPage.all.each do |p|
      p.organization_new_id = nil
      p.save
    end
    Request.all.each do |r|
      r.user_new_id = nil
      r.save
    end
    Scan.all.each do |s|
      s.link_new_id = nil
      s.save
    end
    Style.all.each do |s|
      s.organization_new_id = nil
      s.save
    end
    Subscription.all.each do |s|
      s.organization_new_id = nil
      s.save
    end
    User.all.each do |u|
      u.organization_new_id = nil
      u.invited_by_new_id = nil
      u.save
    end
  end
end
