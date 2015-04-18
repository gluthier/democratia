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

ActiveRecord::Schema.define(version: 20150418140644) do

  create_table "cantons", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "communes", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "political_parties", force: :cascade do |t|
    t.string   "name"
    t.integer  "members"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "political_party_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "canton_id"
    t.integer  "district_id"
    t.integer  "commune_id"
  end

end
