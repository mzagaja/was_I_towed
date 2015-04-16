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

ActiveRecord::Schema.define(version: 20150416002401) do

  create_table "tows", force: :cascade do |t|
    t.integer  "TowNum"
    t.string   "Tow_Firm"
    t.string   "Tow_Firm_Address"
    t.string   "Tow_Firm_Phone"
    t.string   "Vehicle_State"
    t.string   "Vehicle_Year"
    t.string   "Make"
    t.string   "Model"
    t.string   "Color"
    t.string   "Tow_From_Address"
    t.date     "Date"
    t.time     "Time"
    t.string   "geom"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "removed_at"
    t.string   "Vehicle_Plate",    limit: 10
  end

  add_index "tows", ["Vehicle_Plate"], name: "index_tows_on_Vehicle_Plate"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "vehicle_license"
    t.string   "telephone_number"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "state"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
  end

end
