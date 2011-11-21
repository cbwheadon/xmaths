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

ActiveRecord::Schema.define(:version => 20111121161034) do

  create_table "game_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "playground_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "p1_correct"
    t.integer  "p2_correct"
    t.integer  "p1_time"
    t.integer  "p2_time"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "games"
    t.integer  "wins"
    t.integer  "inarow"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "password"
    t.string   "password_digest"
    t.integer  "rank"
  end

  create_table "playgrounds", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.text     "stimulus"
    t.string   "image_url"
    t.integer  "param1"
    t.integer  "param2"
    t.integer  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
