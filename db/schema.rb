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

ActiveRecord::Schema.define(version: 20180208045734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.string "kind", null: false
    t.datetime "expires_at"
    t.string "tokenable_type"
    t.bigint "tokenable_id"
    t.binary "payload"
    t.index ["tokenable_type", "tokenable_id"], name: "index_tokens_on_tokenable_type_and_tokenable_id"
    t.index ["value"], name: "index_tokens_on_value", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "info_about", default: "", null: false
    t.string "permissions", default: [], null: false, array: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
