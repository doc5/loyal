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

ActiveRecord::Schema.define(:version => 20120108083439) do

  create_table "archives_categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "archives_items_count",        :default => 0
    t.integer  "archives_item_fetches_count", :default => 0
    t.string   "url_name"
    t.integer  "position",                    :default => 0
    t.string   "flag_name"
    t.integer  "status",                      :default => 0
    t.string   "lang",                        :default => "zh-cn"
    t.string   "introduction"
    t.text     "description"
    t.integer  "permission",                  :default => 0
    t.text     "permission_encode"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "style_config_id"
    t.text     "style_config_text"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archives_item_fetches", :force => true do |t|
    t.string   "uuid"
    t.string   "title"
    t.string   "unique_url"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "content_way",   :default => 0
    t.text     "content"
    t.text     "virtue_encode"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archives_item_fetches", ["unique_url"], :name => "index_archives_item_fetches_on_unique_url"
  add_index "archives_item_fetches", ["uuid"], :name => "index_archives_item_fetches_on_uuid"

  create_table "archives_items", :force => true do |t|
    t.string   "uuid"
    t.string   "title"
    t.string   "unique_flag",   :default => "URL"
    t.string   "unique_refer"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "content_way",   :default => 0
    t.text     "content"
    t.text     "virtue_encode"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archives_items", ["unique_flag", "unique_refer"], :name => "archives_items_unique_index"
  add_index "archives_items", ["uuid"], :name => "index_archives_items_on_uuid"

  create_table "archives_items_and_archives_categories", :id => false, :force => true do |t|
    t.integer "archives_item_id"
    t.integer "archives_category_id"
    t.integer "ship_flag",            :default => 0
  end

  create_table "artists", :force => true do |t|
    t.string   "uuid"
    t.string   "name"
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["name"], :name => "index_artists_on_name"
  add_index "artists", ["uuid"], :name => "index_artists_on_uuid"

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_authors", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "book_detail_id"
    t.integer  "role_type"
    t.integer  "position",       :default => 0
    t.integer  "status",         :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_boxes", :force => true do |t|
    t.integer  "created_by"
    t.string   "created_ip"
    t.string   "title"
    t.text     "description"
    t.integer  "book_items_count",    :default => 0
    t.integer  "book_comments_count", :default => 0
    t.integer  "status",              :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "url_name"
    t.integer  "position",            :default => 0
    t.string   "flag_name"
    t.integer  "status",              :default => 0
    t.string   "lang",                :default => "zh-cn"
    t.string   "introduction"
    t.text     "description"
    t.integer  "permission",          :default => 0
    t.text     "permission_encode"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "style_config_id"
    t.text     "style_config_text"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_categories", ["url_name", "lang"], :name => "book_categories_url_name"

  create_table "book_category_fetches", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "from_site"
    t.integer  "book_category_id"
    t.integer  "book_details_count", :default => 0
    t.integer  "status",             :default => 0
    t.datetime "deleted_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "position",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_category_fetches", ["from_site"], :name => "index_book_category_fetches_on_from_site"
  add_index "book_category_fetches", ["url"], :name => "index_book_category_fetches_on_url"

  create_table "book_category_fetches_book_details", :id => false, :force => true do |t|
    t.integer "book_detail_id"
    t.integer "book_category_fetch_id"
  end

  create_table "book_comments", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "score_id"
    t.string   "lang"
    t.string   "title"
    t.text     "content"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "status",        :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_comments", ["resource_type", "resource_id"], :name => "book_comments_resource_index"

  create_table "book_detail_avatars", :force => true do |t|
    t.string   "from_uri"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "position",            :default => 0
    t.string   "title"
    t.string   "alt"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "status",              :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_detail_fetches", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.integer  "from_site"
    t.integer  "status",     :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_detail_fetches", ["url"], :name => "index_book_detail_fetches_on_url"

  create_table "book_details", :force => true do |t|
    t.integer  "item_id"
    t.string   "lang",                  :default => "zh-cn"
    t.integer  "status",                :default => 0
    t.datetime "deleted_at"
    t.integer  "book_detail_fetch_id"
    t.integer  "from_site"
    t.string   "from_uri"
    t.integer  "position",              :default => 0
    t.integer  "publisher_id"
    t.string   "author_info"
    t.string   "isbn"
    t.string   "isbn_other"
    t.string   "title"
    t.string   "subtitle"
    t.string   "original_title"
    t.string   "cn_title"
    t.integer  "revision"
    t.string   "price"
    t.string   "price_shop"
    t.string   "production_number"
    t.string   "paper_type"
    t.integer  "paper_count",           :default => 0
    t.integer  "print_count",           :default => 0
    t.string   "lang_tag"
    t.string   "format_tag"
    t.string   "format_paper"
    t.date     "published_at"
    t.string   "published_by"
    t.text     "content_encode"
    t.integer  "overall_avatars_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_details", ["from_uri"], :name => "index_book_details_on_from_uri"

  create_table "book_favorites", :force => true do |t|
    t.integer  "item_id"
    t.string   "lang"
    t.integer  "created_by"
    t.string   "created_ip"
    t.string   "title"
    t.text     "description"
    t.integer  "position",    :default => 0
    t.integer  "status",      :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_fetch_urls", :force => true do |t|
    t.string   "resource_type"
    t.string   "resource_id"
    t.integer  "from_site"
    t.string   "url"
    t.integer  "status",        :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_fetch_urls", ["resource_id", "resource_type", "from_site"], :name => "book_fetch_urls_res_index"

  create_table "book_interests", :force => true do |t|
    t.integer  "item_id"
    t.integer  "score_id"
    t.integer  "status_type"
    t.text     "content"
    t.integer  "permission_type"
    t.text     "permission_encode"
    t.integer  "status",            :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_items", :force => true do |t|
    t.string   "uuid"
    t.string   "isbn"
    t.string   "isbn_other"
    t.integer  "series_id"
    t.string   "published_by"
    t.date     "published_at"
    t.integer  "status",                       :default => 0
    t.integer  "book_comments_count",          :default => 0
    t.integer  "book_notes_count",             :default => 0
    t.integer  "book_interests_count",         :default => 0
    t.integer  "book_scores_count",            :default => 0
    t.integer  "book_favorites_count",         :default => 0
    t.integer  "book_details_count",           :default => 0
    t.integer  "book_origins_count",           :default => 0
    t.integer  "book_interests_doing_count",   :default => 0
    t.integer  "book_interests_wish_count",    :default => 0
    t.integer  "book_interests_collect_count", :default => 0
    t.integer  "total_score",                  :default => 0
    t.integer  "scores_count",                 :default => 0
    t.integer  "scores_a_count",               :default => 0
    t.integer  "scores_b_count",               :default => 0
    t.integer  "scores_c_count",               :default => 0
    t.integer  "scores_d_count",               :default => 0
    t.integer  "scores_e_count",               :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_items", ["isbn"], :name => "index_book_items_on_isbn"
  add_index "book_items", ["isbn_other"], :name => "index_book_items_on_isbn_other"
  add_index "book_items", ["uuid"], :name => "index_book_items_on_uuid"

  create_table "book_notes", :force => true do |t|
    t.integer  "item_id"
    t.integer  "score_id"
    t.integer  "detail_id"
    t.string   "lang"
    t.string   "title"
    t.integer  "chapter_page"
    t.integer  "chapter_title"
    t.text     "content"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "permission_type"
    t.text     "permission_encode"
    t.integer  "book_comments_count", :default => 0
    t.integer  "status",              :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_scores", :force => true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "point"
    t.integer  "status",        :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_scores", ["resource_type", "resource_id"], :name => "book_scores_res_index"

  create_table "book_series", :force => true do |t|
    t.string   "name"
    t.string   "name_en"
    t.integer  "book_items_count",    :default => 0
    t.string   "title"
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "status",              :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_tags", :force => true do |t|
    t.string   "name"
    t.integer  "book_items_count", :default => 0
    t.integer  "users_count",      :default => 0
    t.integer  "status",           :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_tmp_avatars", :force => true do |t|
    t.string   "from_uri"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "position",            :default => 0
    t.string   "title"
    t.string   "alt"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overall_avatars", :force => true do |t|
    t.string   "from_uri"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "position",            :default => 0
    t.string   "title"
    t.string   "alt"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overall_categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "url_name"
    t.integer  "position",            :default => 0
    t.string   "flag_name"
    t.integer  "status",              :default => 0
    t.string   "lang",                :default => "zh-cn"
    t.string   "introduction"
    t.text     "description"
    t.integer  "permission",          :default => 0
    t.text     "permission_encode"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "style_config_id"
    t.text     "style_config_text"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overall_taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "status",        :default => 0
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "position",      :default => 0
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "overall_taggings", ["tag_id"], :name => "tag_id"
  add_index "overall_taggings", ["taggable_id", "taggable_type", "context"], :name => "overall_taggable_index"

  create_table "publishers", :force => true do |t|
    t.integer  "role_type"
    t.string   "name"
    t.text     "description"
    t.integer  "book_items_count",      :default => 0
    t.integer  "book_details_count",    :default => 0
    t.integer  "overall_avatars_count", :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["name", "role_type"], :name => "index_publishers_on_name_and_role_type"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "remark"
    t.text     "description"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "ship_book_items_and_book_categories", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "category_id"
  end

  create_table "ship_book_items_and_book_tags", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "tag_id"
  end

  create_table "ship_users_and_book_tags", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "tag_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tip_categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "url_name"
    t.integer  "position",            :default => 0
    t.string   "flag_name"
    t.integer  "status",              :default => 0
    t.string   "lang",                :default => "zh-cn"
    t.string   "introduction"
    t.text     "description"
    t.integer  "permission",          :default => 0
    t.text     "permission_encode"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "style_config_id"
    t.text     "style_config_text"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tip_comments", :force => true do |t|
    t.string   "uuid"
    t.integer  "post_id"
    t.string   "content"
    t.integer  "created_by"
    t.string   "created_ip"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tip_comments", ["uuid"], :name => "index_tip_comments_on_uuid"

  create_table "tip_posts", :force => true do |t|
    t.string   "uuid"
    t.integer  "context_flag"
    t.string   "title"
    t.text     "content"
    t.string   "lang",               :default => "zh-cn"
    t.integer  "tip_comments_count", :default => 0
    t.integer  "tip_category_id"
    t.integer  "created_by"
    t.string   "created_ip"
    t.datetime "deleted_at"
    t.integer  "permission",         :default => 0
    t.text     "permission_encode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tip_posts", ["uuid"], :name => "index_tip_posts_on_uuid"

  create_table "tip_scores", :force => true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "created_by"
    t.string   "created_ip"
    t.integer  "context_flag"
    t.integer  "point"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tip_taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "position",      :default => 0
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tip_taggings", ["tag_id"], :name => "tip_taggings_tag_id"
  add_index "tip_taggings", ["taggable_id", "taggable_type", "context"], :name => "tip_taggable_index"

  create_table "user_remembers", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.string   "expired_at"
    t.string   "created_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_remembers", ["user_id", "token"], :name => "user_remembers_token"

  create_table "users", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "created_ip"
    t.string   "nick_name"
    t.boolean  "sex"
    t.date     "birthday"
    t.boolean  "birthday_lunar",      :default => false
    t.integer  "status"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email", "deleted_at"], :name => "users_email_deleted_at"

end
