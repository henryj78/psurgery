# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_29_015439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "cell_number"
    t.string "office_number"
    t.string "description"
    t.string "customer_url"
    t.string "boardcertified"
    t.integer "status_id"
    t.integer "zone_id"
    t.integer "state_id"
    t.integer "sale_id"
    t.integer "validate_cus"
    t.string "deactivate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.integer "payment_id"
    t.integer "payment_color"
    t.string "payment_date"
    t.string "county_count"
  end

  create_table "devices", force: :cascade do |t|
    t.integer "customer_id"
    t.string "ip_address"
    t.string "zipcode"
    t.string "os"
    t.string "model"
    t.string "browser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ipad"
    t.string "iphone"
    t.string "mobile"
    t.string "surface"
    t.string "tablet"
    t.string "platform_name"
    t.string "platform_version"
    t.string "android"
    t.string "platform_ios"
    t.string "linux"
    t.string "mac_platform"
    t.string "other_platform"
    t.string "windows_platform"
    t.string "windows_mobile"
    t.string "windows_phone"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "custid"
    t.string "payment_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "type_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sale_payments", force: :cascade do |t|
    t.integer "sale_id"
    t.string "payment_amount"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.string "full_name"
    t.string "first_name"
    t.string "last_name"
    t.string "territory"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.integer "user_id"
    t.string "screen"
    t.string "command"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string "zip_code"
    t.string "latitude"
    t.string "longitude"
    t.string "county"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "zipcode_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zones", force: :cascade do |t|
    t.string "county"
    t.string "state"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
