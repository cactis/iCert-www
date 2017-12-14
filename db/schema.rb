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

ActiveRecord::Schema.define(version: 20171213115421) do

  create_table "certs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.string "title"
    t.datetime "expired_date"
    t.string "aasm_state"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_certs_on_course_id"
    t.index ["user_id"], name: "index_certs_on_user_id"
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.boolean "has_cert"
    t.integer "hours"
    t.integer "percentage"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "aasm_state"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "papers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "cert_id"
    t.string "aasm_state"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cert_id"], name: "index_papers_on_cert_id"
    t.index ["user_id"], name: "index_papers_on_user_id"
  end

  create_table "rpush_apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "device_token", limit: 64, null: false
    t.timestamp "failed_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "badge"
    t.string "device_token", limit: 64
    t.string "sound", default: "default"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.timestamp "delivered_at"
    t.boolean "failed", default: false, null: false
    t.timestamp "failed_at"
    t.integer "error_code"
    t.text "error_description"
    t.timestamp "deliver_after"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids", limit: 16777215
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.timestamp "fail_after"
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false
    t.text "notification"
    t.index ["delivered", "failed"], name: "index_rpush_notifications_multi"
  end

  create_table "treeings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.string "tree_type"
    t.bigint "tree_id"
    t.string "treeable_type"
    t.bigint "treeable_id"
    t.integer "value"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_type", "tree_id"], name: "index_treeings_on_tree_type_and_tree_id"
    t.index ["treeable_type", "treeable_id"], name: "index_treeings_on_treeable_type_and_treeable_id"
    t.index ["type"], name: "index_treeings_on_type"
  end

  create_table "trees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.bigint "user_id"
    t.string "name", null: false
    t.string "title"
    t.string "alias"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.integer "ancestors_count", default: 0, null: false
    t.integer "descendants_count", default: 0, null: false
    t.boolean "active", default: true
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_trees_on_lft"
    t.index ["parent_id"], name: "index_trees_on_parent_id"
    t.index ["rgt"], name: "index_trees_on_rgt"
    t.index ["type", "parent_id", "name"], name: "index_trees_on_type_and_parent_id_and_name", unique: true
    t.index ["type"], name: "index_trees_on_type"
    t.index ["user_id"], name: "index_trees_on_user_id"
  end

  create_table "udollars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "payable_type"
    t.bigint "payable_id"
    t.integer "payment"
    t.integer "balance", default: 0
    t.string "title"
    t.string "message"
    t.string "aasm_state"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payable_type", "payable_id"], name: "index_udollars_on_payable_type_and_payable_id"
    t.index ["user_id"], name: "index_udollars_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "token"
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "aasm_state"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

