# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100905102523) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_login"
    t.string   "commentaire"
    t.integer  "votpos"
    t.integer  "votneg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "story_id"
  end

  create_table "commentsvotes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "titre"
    t.string   "poster"
    t.string   "source"
    t.string   "category"
    t.string   "snip"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string   "titre"
    t.string   "poster"
    t.string   "source"
    t.string   "category"
    t.string   "snip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "votesnb"
    t.string   "avatarurl"
    t.string   "url"
    t.string   "twurl"
    t.string   "bzurl"
    t.string   "fburl"
    t.string   "prettytitre"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "nom"
    t.string   "email"
    t.string   "ville"
    t.string   "societe"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "blog"
    t.string   "viewers"
  end

  create_table "votes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "story_id"
  end

end
