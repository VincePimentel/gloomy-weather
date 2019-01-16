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
    t.integer "rain_volume"
    t.integer "river_volume"
    t.integer "wave_volume"
    t.integer "wind_volume"
    t.integer "leaf_volume"
    t.integer "thunder_volume"
    t.integer "fire_volume"
    t.integer "bird_volume"
    t.integer "cricket_volume"
    t.integer "crowd_volume"
    t.integer "train_volume"
    t.integer "white_volume"
    t.integer "pink_volume"
    t.integer "brown_volume"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
