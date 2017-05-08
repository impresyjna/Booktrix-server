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

ActiveRecord::Schema.define(version: 20170507215156) do

  create_table "book_list_state_translations", force: :cascade do |t|
    t.string   "country"
    t.string   "translation"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "book_list_state_id"
    t.index ["book_list_state_id"], name: "index_book_list_state_translations_on_book_list_state_id"
  end

  create_table "book_list_states", force: :cascade do |t|
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_lists", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.integer  "book_list_state_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["book_id"], name: "index_book_lists_on_book_id"
    t.index ["book_list_state_id"], name: "index_book_lists_on_book_list_state_id"
    t.index ["user_id"], name: "index_book_lists_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "isbn"
    t.string   "image"
    t.text     "description"
    t.string   "publish_date"
    t.integer  "page_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "publisher_city"
  end

  create_table "borrow_histories", force: :cascade do |t|
    t.integer  "user_book_id"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "user_surname"
    t.integer  "borrow_history_state_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["borrow_history_state_id"], name: "index_borrow_histories_on_borrow_history_state_id"
    t.index ["user_book_id"], name: "index_borrow_histories_on_user_book_id"
    t.index ["user_id"], name: "index_borrow_histories_on_user_id"
  end

  create_table "borrow_history_state_trans", force: :cascade do |t|
    t.string   "translation"
    t.string   "country"
    t.integer  "borrow_history_state_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["borrow_history_state_id"], name: "index_borrow_history_state_trans_on_borrow_history_state_id"
  end

  create_table "borrow_history_states", force: :cascade do |t|
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "borrows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_book_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "user_name"
    t.string   "user_surname"
    t.integer  "state_id"
    t.index ["state_id"], name: "index_borrows_on_state_id"
    t.index ["user_book_id"], name: "index_borrows_on_user_book_id"
    t.index ["user_id"], name: "index_borrows_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "font_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
  end

  create_table "gifts", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.boolean  "reserved",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["book_id"], name: "index_gifts_on_book_id"
    t.index ["user_id"], name: "index_gifts_on_user_id"
  end

  create_table "request_to_fixes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.text     "notice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_request_to_fixes_on_book_id"
    t.index ["user_id"], name: "index_request_to_fixes_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "gift_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_id"], name: "index_reservations_on_gift_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "user_books", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "borrowed",    default: false
    t.index ["book_id"], name: "index_user_books_on_book_id"
    t.index ["category_id"], name: "index_user_books_on_category_id"
    t.index ["user_id"], name: "index_user_books_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.boolean  "show_full_name",     default: false
    t.boolean  "show_gifts_boolean", default: false
    t.boolean  "show_activities",    default: false
    t.boolean  "show_books",         default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
    t.string   "login"
    t.string   "name"
    t.string   "surname"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
