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

ActiveRecord::Schema.define(version: 20190430062840) do

  create_table "ahoy_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "name"
    t.text "properties"
    t.timestamp "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "ahoy_visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.integer "user_id"
    t.string "referring_domain"
    t.string "search_keyword"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.integer "screen_height"
    t.integer "screen_width"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "postal_code"
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.timestamp "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "pana_validation_questionaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "subject_id"
    t.integer "page", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "NA1_lo__NA2_hi"
    t.integer "NA3_lo__NA3_hi"
    t.integer "PA3_lo__PA1_hi"
    t.integer "PA4_lo3__PA4_hi"
    t.integer "who1"
    t.integer "who2"
    t.integer "who3"
    t.integer "who4"
    t.integer "who5"
    t.integer "pnv1"
    t.integer "pnv2"
    t.integer "pnv3"
    t.integer "pnv4"
    t.integer "pnv5"
    t.integer "pnv6"
    t.integer "pnv7"
    t.integer "pnv8"
    t.integer "pnv9"
    t.integer "pnv10"
    t.string "emoji_matrix_1"
    t.string "emoji_matrix_2"
    t.integer "swls1"
    t.integer "swls2"
    t.integer "swls3"
    t.integer "swls4"
    t.integer "swls5"
    t.integer "VA2_hi__VA2_lo"
    t.integer "version", default: 0
    t.index ["subject_id"], name: "index_pana_validation_questionaries_on_subject_id"
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "age"
    t.string "gender"
    t.integer "education"
    t.string "residence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.text "accept_language"
    t.integer "visit_id"
    t.string "tic"
  end

end
