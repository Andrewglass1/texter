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

ActiveRecord::Schema.define(:version => 20121107165251) do

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.string   "from"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "station_id"
  end

  create_table "responses", :force => true do |t|
    t.text     "body"
    t.string   "to"
    t.string   "status"
    t.integer  "message_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "code"
    t.string   "lat"
    t.string   "lon"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "line_3"
    t.string   "line_4"
    t.string   "name"
    t.string   "station_together1"
    t.string   "station_together2"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
