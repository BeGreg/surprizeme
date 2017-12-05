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

ActiveRecord::Schema.define(version: 20171205104026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moments", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "photo_url1"
    t.string   "photo_url2"
    t.string   "photo_url3"
    t.string   "photo_url4"
    t.string   "status"
    t.string   "surprise_category"
    t.integer  "location_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["location_id"], name: "index_moments_on_location_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.text     "characteristic"
    t.integer  "price"
    t.float    "supplier_review"
    t.integer  "supplier_review_number"
    t.string   "supplier_category"
    t.float    "delivery_price"
    t.integer  "delivery_time"
    t.string   "photo_url1"
    t.string   "photo_url2"
    t.string   "photo_url3"
    t.string   "photo_url4"
    t.string   "status"
    t.string   "surprise_category"
    t.string   "gender"
    t.integer  "supplier_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.boolean  "rating"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "moment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moment_id"], name: "index_ratings_on_moment_id", using: :btree
    t.index ["product_id"], name: "index_ratings_on_product_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "representations", force: :cascade do |t|
    t.datetime "date"
    t.float    "price_collection",              array: true
    t.float    "del_price"
    t.integer  "moment_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["moment_id"], name: "index_representations_on_moment_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "surprises", force: :cascade do |t|
    t.float    "total_price"
    t.string   "del_first_name"
    t.string   "del_last_name"
    t.string   "del_address"
    t.string   "bill_first_name"
    t.string   "bill_last_name"
    t.string   "bill_address"
    t.integer  "nb_persons"
    t.datetime "moment_date"
    t.float    "ticket_price"
    t.string   "status"
    t.string   "type"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "moment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["moment_id"], name: "index_surprises_on_moment_id", using: :btree
    t.index ["product_id"], name: "index_surprises_on_product_id", using: :btree
    t.index ["user_id"], name: "index_surprises_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "genre"
    t.string   "email"
    t.string   "address"
    t.string   "mobile_phone"
    t.boolean  "rater"
    t.boolean  "admin"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "moments", "locations"
  add_foreign_key "products", "suppliers"
  add_foreign_key "ratings", "moments"
  add_foreign_key "ratings", "products"
  add_foreign_key "ratings", "users"
  add_foreign_key "representations", "moments"
  add_foreign_key "surprises", "moments"
  add_foreign_key "surprises", "products"
  add_foreign_key "surprises", "users"
end
