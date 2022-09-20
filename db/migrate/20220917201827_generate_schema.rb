# frozen_string_literal: true

class GenerateSchema < ActiveRecord::Migration[7.0]
  def change
    create_table 'contact_links', force: :cascade do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.string 'phone'
      t.string 'email'
      t.string 'website'
      t.string 'company'
      t.string 'title'
      t.string 'address'
      t.date 'birthday'
      t.string 'note'
      t.timestamps
      t.index 'created_at', name: 'contact_links_created_at'
    end

    create_table 'data_migrations', primary_key: 'version', id: :string, force: :cascade do |t|
    end

    create_table 'delayed_jobs', force: :cascade do |t|
      t.integer 'priority', default: 0, null: false
      t.integer 'attempts', default: 0, null: false
      t.text 'handler', null: false
      t.text 'last_error'
      t.datetime 'run_at'
      t.datetime 'locked_at'
      t.datetime 'failed_at'
      t.string 'locked_by'
      t.string 'queue'
      t.timestamps
      t.index %w[priority run_at], name: 'delayed_jobs_priority'
    end

    create_table 'email_links', force: :cascade do |t|
      t.text 'email_address'
      t.text 'subject'
      t.text 'body'
      t.timestamps
      t.index 'created_at', name: 'email_links_created_at'
    end

    create_table 'flipper_features', force: :cascade do |t|
      t.string 'key', null: false
      t.timestamps
      t.index ['key'], name: 'index_flipper_features_on_key', unique: true
    end

    create_table 'flipper_gates', force: :cascade do |t|
      t.string 'feature_key', null: false
      t.string 'key', null: false
      t.string 'value'
      t.timestamps
      t.index %w[feature_key key value], name: 'index_flipper_gates_on_feature_key_and_key_and_value', unique: true
    end

    create_table 'sms_links', force: :cascade do |t|
      t.text 'number'
      t.text 'body'
      t.timestamps
    end

    create_table 'telephone_links', force: :cascade do |t|
      t.string 'number'
      t.timestamps
    end

    create_table 'url_links', force: :cascade do |t|
      t.text 'url'
      t.timestamps
    end

    create_table 'wifi_links', force: :cascade do |t|
      t.string 'ssid'
      t.string 'password'
      t.boolean 'hidden'
      t.string 'protocol'
      t.timestamps
    end

    create_table 'organizations', force: :cascade do |t|
      t.string 'name'
      t.string 'billing_email'
      t.datetime 'trial_ends_at', default: -> { "(now() + 'P30D'::interval)" }, null: false
      t.timestamps
    end

    create_table 'links', force: :cascade do |t|
      t.text 'name', null: false
      t.boolean 'dynamic', default: true, null: false
      t.references 'contact_link', foreign_key: true
      t.references 'email_link', foreign_key: true
      t.references 'sms_link', foreign_key: true
      t.references 'telephone_link', foreign_key: true
      t.references 'url_link', foreign_key: true
      t.references 'wifi_link', foreign_key: true
      t.references 'organization', foreign_key: true
      t.string 'dots_color', default: '#000000', null: false
      t.string 'background_color', default: '#ffffff', null: false
      t.string 'password_digest'
      t.string 'corner_squares_color', default: '#000000', null: false
      t.string 'corner_dots_color', default: '#000000', null: false
      t.string 'dots_shape', default: 'square', null: false
      t.string 'corner_squares_shape', default: '', null: false
      t.string 'corner_dots_shape', default: '', null: false
      t.string 'image_url'
      t.datetime 'deleted_at'
      t.timestamps
      t.index ['deleted_at'], name: 'index_links_on_deleted_at'
      t.index %w[name organization_id], name: 'index_links_on_name_and_organization_id', unique: true
      t.check_constraint '((contact_link_id IS NOT NULL)::integer + (email_link_id IS NOT NULL)::integer + (sms_link_id IS NOT NULL)::integer + (telephone_link_id IS NOT NULL)::integer + (url_link_id IS NOT NULL)::integer + (wifi_link_id IS NOT NULL)::integer) = 1',
                         name: 'link_data_xor'
    end

    create_join_table :links, :public_pages do |t|
      t.index %w[link_id public_page_id], name: 'index_links_public_pages_on_link_id_and_public_page_id'
    end

    create_table 'notifications', force: :cascade do |t|
      t.references :recipient, polymorphic: true
      t.string 'type', null: false
      t.jsonb 'params'
      t.datetime 'read_at'
      t.timestamps
      t.index ['read_at'], name: 'index_notifications_on_read_at'
      t.index %w[recipient_type recipient_id], name: 'index_pings_on_recipient'
    end

    create_table 'public_pages', force: :cascade do |t|
      t.string 'name', null: false
      t.references :organization, foreign_key: true
      t.timestamps
    end

    create_table 'users', force: :cascade do |t|
      t.string 'name'
      t.boolean 'can_create_links', default: true
      t.string 'email', null: false
      t.string 'encrypted_password', default: '', null: false
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.string 'confirmation_token'
      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'
      t.string 'unconfirmed_email'
      t.string 'provider'
      t.string 'uid'
      t.text 'private_api_key_ciphertext'
      t.string 'private_api_key_bidx'
      t.references :organization, foreign_key: true
      t.string 'invitation_token'
      t.datetime 'invitation_created_at'
      t.datetime 'invitation_sent_at'
      t.datetime 'invitation_accepted_at'
      t.integer 'invitation_limit'
      t.references :invited_by, polymorphic: true
      t.integer 'invitations_count', default: 0
      t.boolean 'can_edit_links', default: true
      t.boolean 'can_delete_links', default: true
      t.boolean 'can_invite_users', default: true
      t.boolean 'can_edit_users', default: true
      t.boolean 'can_delete_users', default: true
      t.boolean 'can_edit_organization', default: true
      t.boolean 'can_delete_organization', default: true
      t.timestamps
      t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
      t.index ['email'], name: 'index_users_on_email', unique: true
      t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
      t.index ['private_api_key_bidx'], name: 'index_users_on_private_api_key_bidx', unique: true
      t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    end

    create_table 'requests', force: :cascade do |t|
      t.references :user, foreign_key: true
      t.string 'requestable_type'
      t.integer 'method'
      t.timestamps
    end

    create_table 'scans', force: :cascade do |t|
      t.references :link, foreign_key: true
      t.string 'browser_name'
      t.string 'browser_version'
      t.string 'bot_name'
      t.string 'device_name'
      t.string 'platform_name'
      t.string 'platform_version'
      t.string 'language'
      t.string 'city'
      t.string 'country'
      t.timestamps
    end

    create_table 'styles', force: :cascade do |t|
      t.string 'name', null: false
      t.references :organization, foreign_key: true
      t.string 'dots_color', default: '#000000', null: false
      t.string 'background_color', default: '#ffffff', null: false
      t.string 'corner_squares_color', default: '#000000', null: false
      t.string 'corner_dots_color', default: '#000000', null: false
      t.string 'dots_shape', default: 'square', null: false
      t.string 'corner_squares_shape', default: '', null: false
      t.string 'corner_dots_shape', default: '', null: false
      t.string 'image_url'
      t.timestamps
    end

    create_table 'subscriptions', force: :cascade do |t|
      t.integer 'paddle_subscription_id', null: false
      t.integer 'subscription_plan_id', null: false
      t.references :organization, foreign_key: true
      t.string 'update_url', null: false
      t.string 'cancel_url', null: false
      t.string 'status', null: false
      t.datetime 'next_bill_date'
      t.datetime 'paused_at'
      t.datetime 'paused_from'
      t.string 'paused_reason'
      t.datetime 'cancellation_effective_date'
      t.timestamps
    end

    create_table 'versions', force: :cascade do |t|
      t.string 'item_type', null: false
      t.string 'item_id', null: false
      t.string 'event', null: false
      t.string 'whodunnit'
      t.text 'object'
      t.datetime 'created_at'
      t.text 'object_changes'
      t.index %w[item_type item_id], name: 'index_versions_on_item_type_and_item_id'
    end
  end
end
