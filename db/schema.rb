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

ActiveRecord::Schema.define(version: 20130607123837) do

  create_table "base_routes", force: true do |t|
    t.string   "origin"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "base_routes", ["origin", "destination"], name: "index_base_routes_on_origin_and_destination", unique: true

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "priced_base_routes", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.float    "price"
    t.string   "currency"
    t.integer  "search_engine_id"
    t.integer  "base_route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "priced_strike_routes", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "strike_date"
    t.float    "price"
    t.string   "currency"
    t.integer  "search_engine_id"
    t.integer  "base_route_id"
    t.integer  "strike_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scrapes", force: true do |t|
    t.text     "base_route_ids"
    t.text     "strike_ids"
    t.string   "date_string"
    t.text     "search_engine_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_engines", force: true do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_engines", ["identifier"], name: "index_search_engines_on_identifier", unique: true

  create_table "strikes", force: true do |t|
    t.string   "origin"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strikes", ["origin", "destination"], name: "index_strikes_on_origin_and_destination", unique: true

end
