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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 3) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checklists", force: :cascade do |t|
    t.text     "description"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checklists", ["task_id"], name: "index_checklists_on_task_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "board_name"
    t.string   "list_name"
    t.string   "checklist_name"
    t.string   "environment"
    t.datetime "reported_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["report_id"], name: "index_tasks_on_report_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "token"
    t.string   "username"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
