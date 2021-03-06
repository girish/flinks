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

ActiveRecord::Schema.define(:version => 20110114100053) do

  create_table "links", :force => true do |t|
    t.text     "url"
    t.string   "hash"
    t.integer  "comments_count", :default => 0
    t.integer  "likes_count",    :default => 0
    t.integer  "shares_count",   :default => 0
    t.datetime "last_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["hash"], :name => "index_links_on_hash", :unique => true

  create_table "links_users", :id => false, :force => true do |t|
    t.integer "link_id"
    t.string  "user_fb_id"
  end

  create_table "users", :force => true do |t|
    t.string   "fb_id"
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
