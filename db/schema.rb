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

ActiveRecord::Schema.define(version: 2021_05_07_131609) do

  create_table "cards", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "oracle_id", null: false
    t.string "name", null: false
    t.string "set", null: false
    t.float "price_usd"
    t.float "price_usd_foil"
    t.float "price_eur"
    t.float "price_eur_foil"
    t.float "price_tix"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "collector_number"
    t.index ["id"], name: "index_cards_on_id", unique: true
    t.index ["set", "collector_number"], name: "index_cards_on_set_and_collector_number", unique: true
  end

end
