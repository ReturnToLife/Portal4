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

ActiveRecord::Schema.define(:version => 20130429173106) do

  create_table "acomments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "score_id"
  end

  add_index "acomments", ["article_id"], :name => "index_acomments_on_article_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "publication_date"
    t.string   "thumbnail"
    t.integer  "nb_comments"
    t.text     "content"
    t.string   "category"
    t.integer  "status"
    t.integer  "score_id"
    t.integer  "event_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "group_id"
  end

  create_table "authors", :force => true do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.string   "job"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "category"
    t.integer  "user_id"
    t.integer  "score_id"
    t.string   "title"
    t.text     "description"
    t.string   "place"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "gcomments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "gossip_id"
    t.integer  "score_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gossips", :force => true do |t|
    t.string   "text"
    t.integer  "score_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "commentary"
    t.text     "contact"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "job"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "promos", :force => true do |t|
    t.string   "title"
    t.integer  "school_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ressources", :force => true do |t|
    t.string   "name"
    t.date     "borrow_date"
    t.date     "estimate_date"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "group_id"
    t.text     "commentary"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scores", :force => true do |t|
    t.integer  "score_pos"
    t.integer  "score_neg"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "promo_id"
    t.integer  "school_id"
    t.string   "city"
    t.string   "photo_url"
    t.string   "avatar_url"
    t.integer  "uid"
    t.string   "report_url"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "votes", :force => true do |t|
    t.integer  "score_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "login"
  end

end
