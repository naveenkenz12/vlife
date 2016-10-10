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

ActiveRecord::Schema.define(version: 20161010165018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", primary_key: ["user", "friend"], force: :cascade do |t|
    t.string   "user",                           null: false
    t.string   "friend",                         null: false
    t.string   "status",     default: "waiting", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_check "friends", "((status)::text = ANY ((ARRAY['waiting'::character varying, 'following'::character varying, 'accepted'::character varying])::text[]))", name: "status_check"

  create_table "institutions", primary_key: "ins_id", id: :string, force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", primary_key: ["country", "city"], force: :cascade do |t|
    t.string   "country",    null: false
    t.string   "state"
    t.string   "city",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", primary_key: "q_id", id: :string, force: :cascade do |t|
    t.string   "question_description", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_profiles", primary_key: "u_id", id: :string, force: :cascade do |t|
    t.string   "first_name",                null: false
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "gender",                    null: false
    t.string   "language"
    t.date     "birthday",                  null: false
    t.string   "rel_status"
    t.string   "privacy",     default: "O", null: false
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_check "user_profiles", "((gender)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying, 'O'::character varying])::text[]))", name: "gender_check"
  add_check "user_profiles", "((privacy)::text = ANY ((ARRAY['O'::character varying, 'F'::character varying, 'C'::character varying])::text[]))", name: "privacy_check"
  add_check "user_profiles", "(birthday < now())", name: "birthday_check"

  create_table "users", primary_key: "u_id", id: :string, force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "phone_no",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
    t.string   "password_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["phone_no"], name: "index_users_on_phone_no", unique: true, using: :btree
  end

  add_foreign_key "friends", "users", column: "friend", primary_key: "u_id", name: "friends_friend_fkey"
  add_foreign_key "friends", "users", column: "user", primary_key: "u_id", name: "friends_user_fkey"
  add_foreign_key "institutions", "locations", column: "country", primary_key: "country", name: "institutions_country_fkey"
  add_foreign_key "user_profiles", "locations", column: "country", primary_key: "country", name: "user_profiles_country_fkey"
  add_foreign_key "user_profiles", "users", column: "u_id", primary_key: "u_id", name: "user_profiles_u_id_fkey"
end
