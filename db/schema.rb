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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120814195031) do

  create_table "card_packs", :force => true do |t|
    t.integer  "challenge_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.string   "source"
    t.integer  "set"
    t.text     "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "challenges", :force => true do |t|
    t.string   "name"
    t.integer  "n_cards"
    t.text     "set"
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "client_param"
    t.text     "server_param"
    t.text     "kind"
    t.boolean  "repeatable",   :default => false
  end

  create_table "notifications", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "details"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id"
    t.text     "cards_in"
    t.text     "cards_out"
    t.integer  "status"
    t.date     "renewal"
    t.integer  "sender_id"
    t.integer  "challenge_id"
    t.string   "data",         :default => ""
  end

  create_table "user_cards", :force => true do |t|
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "user_id"
    t.integer  "card_id"
    t.integer  "card_pack_id"
    t.text     "log"
    t.boolean  "locked",       :default => false
  end

  create_table "user_challenges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "facebook_id",     :limit => 8
    t.integer  "twitter_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.text     "friends"
    t.integer  "foursquare_id"
    t.text     "referals"
    t.integer  "cards_count",                  :default => 0
    t.text     "album"
    t.string   "fb_access_token"
    t.string   "tw_access_token"
  end

end
