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

ActiveRecord::Schema[7.0].define(version: 2022_09_14_011846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "contact_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "email_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "email_address"
    t.text "subject"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "dynamic", default: true, null: false
    t.uuid "contact_link_id"
    t.uuid "email_link_id"
    t.uuid "sms_link_id"
    t.uuid "telephone_link_id"
    t.uuid "url_link_id"
    t.uuid "wifi_link_id"
    t.uuid "organization_id"
    t.string "dots_color", default: "#000000", null: false
    t.string "background_color", default: "#ffffff", null: false
    t.string "password_digest"
    t.string "corner_squares_color", default: "#000000", null: false
    t.string "corner_dots_color", default: "#000000", null: false
    t.datetime "deleted_at"
    t.string "dots_shape", default: "square", null: false
    t.string "corner_squares_shape", default: "", null: false
    t.string "corner_dots_shape", default: "", null: false
    t.string "image_url"
    t.index ["contact_link_id"], name: "index_links_on_contact_link_id"
    t.index ["deleted_at"], name: "index_links_on_deleted_at"
    t.index ["email_link_id"], name: "index_links_on_email_link_id"
    t.index ["name", "organization_id"], name: "index_links_on_name_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_links_on_organization_id"
    t.index ["sms_link_id"], name: "index_links_on_sms_link_id"
    t.index ["telephone_link_id"], name: "index_links_on_telephone_link_id"
    t.index ["url_link_id"], name: "index_links_on_url_link_id"
    t.index ["user_id"], name: "index_links_on_user_id"
    t.index ["wifi_link_id"], name: "index_links_on_wifi_link_id"
    t.check_constraint "((contact_link_id IS NOT NULL)::integer + (email_link_id IS NOT NULL)::integer + (sms_link_id IS NOT NULL)::integer + (telephone_link_id IS NOT NULL)::integer + (url_link_id IS NOT NULL)::integer + (wifi_link_id IS NOT NULL)::integer) = 1", name: "link_data_xor"
  end

  create_table "links_public_pages", id: false, force: :cascade do |t|
    t.uuid "link_id", null: false
    t.uuid "public_page_id", null: false
    t.index ["link_id", "public_page_id"], name: "index_links_public_pages_on_link_id_and_public_page_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "recipient_type", null: false
    t.uuid "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_pings_on_recipient"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "billing_email"
    t.datetime "trial_ends_at", default: -> { "(now() + 'P30D'::interval)" }, null: false
  end

  create_table "public_pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_public_pages_on_organization_id"
  end

  create_table "requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "requestable_type"
    t.integer "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "scans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "link_id"
    t.string "browser_name"
    t.string "browser_version"
    t.string "bot_name"
    t.string "device_name"
    t.string "platform_name"
    t.string "platform_version"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "country"
    t.index ["link_id"], name: "index_scans_on_link_id"
  end

  create_table "sms_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "number"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "organization_id", null: false
    t.string "dots_color", default: "#000000", null: false
    t.string "background_color", default: "#ffffff", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "corner_squares_color", default: "#000000", null: false
    t.string "corner_dots_color", default: "#000000", null: false
    t.string "dots_shape", default: "square", null: false
    t.string "corner_squares_shape", default: "", null: false
    t.string "corner_dots_shape", default: "", null: false
    t.string "image_url"
    t.index ["organization_id"], name: "index_styles_on_organization_id"
  end

  create_table "telephone_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "url_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "can_create_links", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.uuid "organization_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.uuid "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "can_edit_links", default: true
    t.boolean "can_delete_links", default: true
    t.boolean "can_invite_users", default: true
    t.boolean "can_edit_users", default: true
    t.boolean "can_delete_users", default: true
    t.boolean "can_edit_organization", default: true
    t.boolean "can_delete_organization", default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
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

  create_table "wifi_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ssid"
    t.string "password"
    t.boolean "hidden"
    t.string "protocol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
