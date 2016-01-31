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

ActiveRecord::Schema.define(version: 20160131024539) do

  create_table "eeg_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "timestamp"
    t.integer  "attention"
    t.integer  "meditation"
    t.float    "delta",       limit: 24
    t.float    "theta",       limit: 24
    t.float    "low_alpha",   limit: 24
    t.float    "high_alpha",  limit: 24
    t.float    "low_beta",    limit: 24
    t.float    "high_beta",   limit: 24
    t.float    "low_gamma",   limit: 24
    t.float    "high_gamma",  limit: 24
    t.integer  "poor_signal"
    t.integer  "blinks"
    t.float    "max_blink",   limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["timestamp", "attention", "meditation"], name: "index_eeg_records_on_timestamp_and_attention_and_meditation", using: :btree
  end

  create_table "network_hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_network_hosts_on_name", using: :btree
  end

  create_table "network_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_network_names_on_name", using: :btree
  end

  create_table "network_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "network_name_id"
    t.integer  "network_host_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["end_time"], name: "index_network_records_on_end_time", using: :btree
    t.index ["start_time"], name: "index_network_records_on_start_time", using: :btree
  end

end
