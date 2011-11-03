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

ActiveRecord::Schema.define(:version => 20111103171255) do

  create_table "assets", :force => true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "attached_to_id"
    t.string   "attached_to_type"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "birders", :force => true do |t|
    t.text     "author"
    t.text     "description"
    t.text     "references"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "birds", :force => true do |t|
    t.text     "name",                   :null => false
    t.text     "url",                    :null => false
    t.integer  "genus_type_id"
    t.text     "foritself"
    t.integer  "habitat_id"
    t.text     "brand"
    t.text     "fse_name"
    t.integer  "fse_org_style_id"
    t.text     "fse_owner_founder"
    t.text     "fse_significant_member"
    t.text     "fse_mission_statement"
    t.text     "op_name"
    t.integer  "op_org_style_id"
    t.text     "op_vip_founders"
    t.text     "op_typical_member"
    t.text     "formation"
    t.text     "history"
    t.text     "lifespan"
    t.text     "resource"
    t.text     "availability"
    t.text     "participation"
    t.text     "tasks"
    t.text     "modularity"
    t.text     "granularity"
    t.text     "metrics"
    t.text     "alliances"
    t.text     "clients"
    t.text     "sponsors"
    t.text     "elites"
    t.integer  "comments_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.text     "summary"
  end

  create_table "comments", :force => true do |t|
    t.text     "author",     :null => false
    t.text     "comment",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genus_types", :force => true do |t|
    t.text     "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habitats", :force => true do |t|
    t.text     "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "org_styles", :force => true do |t|
    t.text     "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", :force => true do |t|
    t.text     "habitats"
    t.text     "genus_types"
    t.text     "ids"
    t.text     "text_search"
    t.text     "fse_org_styles"
    t.text     "op_org_styles"
    t.string   "order_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "view_fields"
    t.text     "hide_fields"
    t.integer  "pagination"
    t.integer  "schema_id"
    t.text     "org_styles"
  end

  create_table "schema_fields", :force => true do |t|
    t.integer  "schema_id"
    t.string   "key"
    t.string   "short_name"
    t.text     "description"
    t.text     "instructions"
    t.integer  "position"
    t.text     "render_value_func"
    t.text     "render_form_func"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "render_list_value_func"
    t.string   "form_type"
    t.string   "group_name"
  end

  create_table "schemas", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "field_descriptions"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",     :limit => 128,                :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
