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

ActiveRecord::Schema.define(version: 20150419030405) do

  create_table "cantons", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "json_id_canton"
  end

  create_table "commenters", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "commenter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "canton_id"
    t.integer  "json_id_district"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "districts_id"
    t.integer  "json_id_municipality"
    t.integer  "canton_id"
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
    t.string   "website"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
