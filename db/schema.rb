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

ActiveRecord::Schema.define(version: 20180812114044) do

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "description"
    t.string   "github"
    t.string   "external_uri"
    t.integer  "user_id"
    t.string   "video_url",    default: "https://previews.dropbox.com/p/orig/AALLu4qexe4eU7T5bGxzyH9_PR8rB915D7agQUw_uIzME3onBZDmO12fowl6_McLBUqDARxX3KSMvEATbxJee989K67r4KKGASU1-9165ihl1tIUQXq59G-3vHdEKiTI2J2WfY2Vu9hP3GYc_Iew4HQx7aaOYTLugxx-m9Xj6ENJmNCmYfcOIdKId_kGbeGysGcCYA_WpGkP-fCT_ClrTCkt/p.gif?size=1024x768&size_mode=3"
    t.string   "blog_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
