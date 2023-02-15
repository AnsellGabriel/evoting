# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_13_132813) do
  create_table "candidates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "position_id", null: false
    t.string "name"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_candidates_on_event_id"
    t.index ["position_id"], name: "index_candidates_on_position_id"
  end

  create_table "elecoms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elections", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id"
    t.string "voter_code"
    t.string "station"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_elections_on_member_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "required_complete"
    t.boolean "allow_single"
    t.boolean "active"
    t.boolean "election"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id"
    t.string "name"
    t.string "description"
    t.string "area"
    t.boolean "voted"
    t.datetime "vote_date"
    t.string "station"
    t.string "vote_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_members_on_event_id"
  end

  create_table "positions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.integer "vacant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_positions_on_event_id"
  end

  create_table "votes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "candidate_id", null: false
    t.bigint "member_id", null: false
    t.bigint "position_id", null: false
    t.decimal "vote_amount", precision: 18, scale: 2
    t.string "station"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["event_id"], name: "index_votes_on_event_id"
    t.index ["member_id"], name: "index_votes_on_member_id"
    t.index ["position_id"], name: "index_votes_on_position_id"
  end

  add_foreign_key "candidates", "events"
  add_foreign_key "candidates", "positions"
  add_foreign_key "positions", "events"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "events"
  add_foreign_key "votes", "members"
  add_foreign_key "votes", "positions"
end
