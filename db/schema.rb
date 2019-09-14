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

ActiveRecord::Schema.define(version: 20190914012506) do

  create_table "contributions", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.integer  "user_id"
    t.datetime "updated_at", null: false
  end

  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id"

  create_table "contributions_groups", force: :cascade do |t|
    t.integer  "contribution_id"
    t.integer  "group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contributions_groups", ["contribution_id"], name: "index_contributions_groups_on_contribution_id"
  add_index "contributions_groups", ["group_id"], name: "index_contributions_groups_on_group_id"

  create_table "follows", force: :cascade do |t|
    t.boolean  "following"
    t.datetime "followed_at"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["group_id"], name: "index_follows_on_group_id"
  add_index "follows", ["user_id"], name: "index_follows_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.integer  "user_id"
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
