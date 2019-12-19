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

ActiveRecord::Schema.define(version: 2019_12_19_203935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversions", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_conversions_on_match_id"
    t.index ["player_id"], name: "index_conversions_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "opponent"
    t.integer "score_vrp"
    t.integer "score_opponent"
    t.string "won"
    t.date "date"
    t.string "type"
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_matches_on_season_id"
  end

  create_table "penalties", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_penalties_on_match_id"
    t.index ["player_id"], name: "index_penalties_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.boolean "admin"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.date "start_year"
    t.date "end_year"
    t.string "result"
    t.integer "won_count"
    t.integer "lost_count"
    t.integer "draw_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selections", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_selections_on_match_id"
    t.index ["player_id"], name: "index_selections_on_player_id"
  end

  create_table "tries", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_tries_on_match_id"
    t.index ["player_id"], name: "index_tries_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "conversions", "matches"
  add_foreign_key "conversions", "players"
  add_foreign_key "penalties", "matches"
  add_foreign_key "penalties", "players"
  add_foreign_key "players", "users"
  add_foreign_key "selections", "matches"
  add_foreign_key "selections", "players"
  add_foreign_key "tries", "matches"
  add_foreign_key "tries", "players"
end
