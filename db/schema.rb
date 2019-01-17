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

ActiveRecord::Schema.define(version: 2019_01_16_002015) do

  create_table "presets", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "description"
    t.integer "rain_volume", default: 0
    t.integer "river_volume", default: 0
    t.integer "wave_volume", default: 0
    t.integer "wind_volume", default: 0
    t.integer "leaf_volume", default: 0
    t.integer "thunder_volume", default: 0
    t.integer "fire_volume", default: 0
    t.integer "bird_volume", default: 0
    t.integer "cricket_volume", default: 0
    t.integer "crowd_volume", default: 0
    t.integer "train_volume", default: 0
    t.integer "white_volume", default: 0
    t.integer "pink_volume", default: 0
    t.integer "brown_volume", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
