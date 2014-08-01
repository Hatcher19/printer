# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140601211013) do

  create_table "accounts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "addresses", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "line_one"
    t.string   "line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "customer_id"
    t.string   "ship_type"
  end

  create_table "artworks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "color"
    t.string   "location"
    t.integer  "order_id"
  end

  create_table "customers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization"
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "customer_phone"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  add_index "customers", ["account_id"], name: "index_customers_on_account_id"

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_date"
    t.string   "name"
    t.string   "category"
    t.string   "order_type"
    t.string   "order_status"
    t.string   "product_status"
    t.string   "art_status"
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "shipping"
    t.integer  "uuid"
  end

  add_index "orders", ["account_id"], name: "index_orders_on_account_id"

  create_table "products", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "style"
    t.string   "color"
    t.integer  "quantity"
    t.integer  "xs"
    t.integer  "small"
    t.integer  "med"
    t.integer  "large"
    t.integer  "xl"
    t.integer  "xxl"
    t.integer  "xxxl"
    t.integer  "ivxl"
    t.integer  "vxl"
    t.integer  "vixl"
    t.integer  "order_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "braintree_customer_id"
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
