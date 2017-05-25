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

ActiveRecord::Schema.define(version: 20170525150816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ranks", force: :cascade do |t|
    t.string   "playlist"
    t.string   "rank"
    t.string   "division"
    t.integer  "rating"
    t.string   "division_up"
    t.string   "division_down"
    t.integer  "games"
    t.integer  "user_id"
    t.integer  "version"
    t.boolean  "played"
    t.string   "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "wins"
    t.integer  "goals"
    t.decimal  "goal_ratio"
    t.integer  "saves"
    t.integer  "shots"
    t.integer  "assists"
    t.integer  "mvps"
    t.integer  "version"
    t.integer  "user_id"
    t.boolean  "played"
    t.string   "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "telegram_id"
    t.string   "player_id"
    t.string   "platform"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "chat_id"
    t.jsonb    "bot_command", default: {}
    t.boolean  "report",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "found"
    t.index ["telegram_id", "chat_id"], name: "index_users_on_telegram_id_and_chat_id", unique: true, using: :btree
  end

end
