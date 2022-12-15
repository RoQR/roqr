# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_15_232233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["viewer", "editor", "administrator"]

  create_table "admin_users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "contact_links", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.string "company"
    t.string "title"
    t.string "address"
    t.date "birthday"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "first_name_ciphertext"
    t.text "last_name_ciphertext"
    t.text "phone_ciphertext"
    t.text "email_ciphertext"
    t.text "website_ciphertext"
    t.text "company_ciphertext"
    t.text "title_ciphertext"
    t.text "address_ciphertext"
    t.text "birthday_ciphertext"
    t.text "note_ciphertext"
    t.index ["created_at"], name: "contact_links_created_at"
  end

  create_table "custom_domains", force: :cascade do |t|
    t.string "url"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Submitted"
    t.string "dns_validation_hostname"
    t.string "dns_validation_target"
    t.string "ipv4_target"
    t.string "ipv6_target"
    t.index ["organization_id"], name: "index_custom_domains_on_organization_id"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "email_links", force: :cascade do |t|
    t.text "email_address"
    t.text "subject"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "email_address_ciphertext"
    t.text "subject_ciphertext"
    t.text "body_ciphertext"
    t.index ["created_at"], name: "email_links_created_at"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.text "name", null: false
    t.boolean "dynamic", default: true, null: false
    t.bigint "contact_link_id"
    t.bigint "email_link_id"
    t.bigint "sms_link_id"
    t.bigint "telephone_link_id"
    t.bigint "url_link_id"
    t.bigint "wifi_link_id"
    t.bigint "organization_id"
    t.string "dots_color", default: "#000000", null: false
    t.string "background_color", default: "#ffffff", null: false
    t.string "password_digest"
    t.string "corner_squares_color", default: "#000000", null: false
    t.string "corner_dots_color", default: "#000000", null: false
    t.string "dots_shape", default: "square", null: false
    t.string "corner_squares_shape", default: "", null: false
    t.string "corner_dots_shape", default: "", null: false
    t.string "image_url"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "transparent_background", default: false, null: false
    t.bigint "custom_domain_id"
    t.index ["archived_at"], name: "index_links_on_archived_at"
    t.index ["contact_link_id"], name: "index_links_on_contact_link_id"
    t.index ["custom_domain_id"], name: "index_links_on_custom_domain_id"
    t.index ["email_link_id"], name: "index_links_on_email_link_id"
    t.index ["name", "organization_id"], name: "index_links_on_name_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_links_on_organization_id"
    t.index ["sms_link_id"], name: "index_links_on_sms_link_id"
    t.index ["telephone_link_id"], name: "index_links_on_telephone_link_id"
    t.index ["url_link_id"], name: "index_links_on_url_link_id"
    t.index ["wifi_link_id"], name: "index_links_on_wifi_link_id"
    t.check_constraint "((contact_link_id IS NOT NULL)::integer + (email_link_id IS NOT NULL)::integer + (sms_link_id IS NOT NULL)::integer + (telephone_link_id IS NOT NULL)::integer + (url_link_id IS NOT NULL)::integer + (wifi_link_id IS NOT NULL)::integer) = 1", name: "link_data_xor"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
    t.index ["recipient_type", "recipient_id"], name: "index_pings_on_recipient"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "billing_email"
    t.datetime "trial_ends_at", default: -> { "(now() + 'P30D'::interval)" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "requestable_type"
    t.integer "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "scans", force: :cascade do |t|
    t.bigint "link_id"
    t.string "browser_name"
    t.string "browser_version"
    t.string "bot_name"
    t.string "device_name"
    t.string "platform_name"
    t.string "platform_version"
    t.string "language"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_scans_on_link_id"
  end

  create_table "sms_links", force: :cascade do |t|
    t.text "number"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "number_ciphertext"
    t.text "body_ciphertext"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organization_id"
    t.string "dots_color", default: "#000000", null: false
    t.string "background_color", default: "#ffffff", null: false
    t.string "corner_squares_color", default: "#000000", null: false
    t.string "corner_dots_color", default: "#000000", null: false
    t.string "dots_shape", default: "square", null: false
    t.string "corner_squares_shape", default: "", null: false
    t.string "corner_dots_shape", default: "", null: false
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "corner_squares_copy_dots", default: true, null: false
    t.boolean "corner_dots_copy_dots", default: true, null: false
    t.boolean "transparent_background", default: false, null: false
    t.index ["organization_id"], name: "index_styles_on_organization_id"
  end

  create_table "subscription_payments", force: :cascade do |t|
    t.bigint "subscription_id"
    t.string "currency"
    t.datetime "event_time"
    t.string "payment_method"
    t.string "receipt_url"
    t.string "sale_gross"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paddle_subscription_payment_id"
    t.index ["subscription_id"], name: "index_subscription_payments_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "paddle_subscription_id", null: false
    t.integer "subscription_plan_id", null: false
    t.bigint "organization_id"
    t.string "update_url", null: false
    t.string "cancel_url", null: false
    t.string "status", null: false
    t.datetime "next_bill_date"
    t.datetime "paused_at"
    t.datetime "paused_from"
    t.string "paused_reason"
    t.datetime "cancellation_effective_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_subscriptions_on_organization_id"
    t.index ["paddle_subscription_id"], name: "index_subscriptions_on_paddle_subscription_id"
  end

  create_table "telephone_links", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "number_ciphertext"
  end

  create_table "url_links", force: :cascade do |t|
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "url_ciphertext"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.text "private_api_key_ciphertext"
    t.string "private_api_key_bidx"
    t.bigint "organization_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "role", default: "administrator", null: false, enum_type: "user_role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["private_api_key_bidx"], name: "index_users_on_private_api_key_bidx", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.string "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wifi_links", force: :cascade do |t|
    t.string "ssid"
    t.string "password"
    t.boolean "hidden"
    t.string "protocol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ssid_ciphertext"
    t.text "password_ciphertext"
    t.text "hidden_ciphertext"
    t.text "protocol_ciphertext"
  end

  add_foreign_key "custom_domains", "organizations"
  add_foreign_key "links", "contact_links"
  add_foreign_key "links", "email_links"
  add_foreign_key "links", "organizations"
  add_foreign_key "links", "sms_links"
  add_foreign_key "links", "telephone_links"
  add_foreign_key "links", "url_links"
  add_foreign_key "links", "wifi_links"
  add_foreign_key "requests", "users"
  add_foreign_key "scans", "links"
  add_foreign_key "styles", "organizations"
  add_foreign_key "subscription_payments", "subscriptions"
  add_foreign_key "subscriptions", "organizations"
  add_foreign_key "users", "organizations"
end
