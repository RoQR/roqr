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

ActiveRecord::Schema[7.0].define(version: 2022_09_19_131738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["created_at"], name: "contact_links_created_at"
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
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_link_id"], name: "index_links_on_contact_link_id"
    t.index ["deleted_at"], name: "index_links_on_deleted_at"
    t.index ["email_link_id"], name: "index_links_on_email_link_id"
    t.index ["name", "organization_id"], name: "index_links_on_name_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_links_on_organization_id"
    t.index ["sms_link_id"], name: "index_links_on_sms_link_id"
    t.index ["telephone_link_id"], name: "index_links_on_telephone_link_id"
    t.index ["url_link_id"], name: "index_links_on_url_link_id"
    t.index ["wifi_link_id"], name: "index_links_on_wifi_link_id"
    t.check_constraint "((contact_link_id IS NOT NULL)::integer + (email_link_id IS NOT NULL)::integer + (sms_link_id IS NOT NULL)::integer + (telephone_link_id IS NOT NULL)::integer + (url_link_id IS NOT NULL)::integer + (wifi_link_id IS NOT NULL)::integer) = 1", name: "link_data_xor"
  end

  create_table "links_public_pages", id: false, force: :cascade do |t|
    t.bigint "link_id", null: false
    t.bigint "public_page_id", null: false
    t.index ["link_id", "public_page_id"], name: "index_links_public_pages_on_link_id_and_public_page_id"
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

  create_table "public_pages", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_public_pages_on_organization_id"
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
  end

  create_table "url_links", force: :cascade do |t|
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.boolean "can_create_links", default: true
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
    t.boolean "can_edit_links", default: true
    t.boolean "can_delete_links", default: true
    t.boolean "can_invite_users", default: true
    t.boolean "can_edit_users", default: true
    t.boolean "can_delete_users", default: true
    t.boolean "can_edit_organization", default: true
    t.boolean "can_delete_organization", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_foreign_key "links", "contact_links"
  add_foreign_key "links", "email_links"
  add_foreign_key "links", "organizations"
  add_foreign_key "links", "sms_links"
  add_foreign_key "links", "telephone_links"
  add_foreign_key "links", "url_links"
  add_foreign_key "links", "wifi_links"
  add_foreign_key "public_pages", "organizations"
  add_foreign_key "requests", "users"
  add_foreign_key "scans", "links"
  add_foreign_key "styles", "organizations"
  add_foreign_key "subscription_payments", "subscriptions"
  add_foreign_key "subscriptions", "organizations"
  add_foreign_key "users", "organizations"
end
