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

ActiveRecord::Schema.define(version: 20151106100552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.string   "first_name"
    t.string   "surname"
    t.integer  "adults_number"
    t.integer  "children_number"
    t.date     "beginning"
    t.date     "end"
    t.decimal  "discount",                   precision: 2, scale: 2
    t.integer  "room_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "email_address"
    t.string   "phone_number",    limit: 12
  end

  add_index "reservations", ["room_id"], name: "index_reservations_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.integer  "room_number"
    t.integer  "beds_number"
    t.decimal  "price_per_adult", precision: 5, scale: 2
    t.decimal  "price_per_child", precision: 5, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "reservations", "rooms"
end
