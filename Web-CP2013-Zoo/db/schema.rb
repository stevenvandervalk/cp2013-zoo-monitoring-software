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

ActiveRecord::Schema.define(:version => 20121020050735) do

  create_table "animals", :force => true do |t|
    t.string  "animal_id"
    t.string  "name"
    t.integer "cage_id"
  end

  create_table "cages", :force => true do |t|
    t.float    "size"
    t.string   "category"
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "human_present"
    t.datetime "date_last_fed"
    t.datetime "date_last_cleaned"
    t.string   "animal_name"
  end

  create_table "doors", :force => true do |t|
    t.boolean "open"
    t.integer "entrance_id"
  end

  create_table "employees", :force => true do |t|
    t.string   "employee_id"
    t.string   "name"
    t.integer  "cage_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "entrances", :force => true do |t|
    t.integer "cage_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "employee_id"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
