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

ActiveRecord::Schema.define(:version => 20120627103906) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addres", :force => true do |t|
    t.integer  "rada_id"
    t.integer  "city_id"
    t.integer  "street_id"
    t.string   "house",        :limit => 10
    t.string   "suf_house",    :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.string   "full_address", :limit => nil
  end

  create_table "addresses", :force => true do |t|
    t.integer  "number"
    t.string   "suffix"
    t.string   "streetname"
    t.string   "streettype"
    t.string   "seloname"
    t.integer  "village_id"
    t.string   "fulladr"
    t.float    "point_x"
    t.float    "point_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addrgeos", :force => true do |t|
    t.string   "fulladr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

# Could not dump table "adr_data" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "animals", :force => true do |t|
    t.integer  "pgo_id",       :limit => 8
    t.date     "datezap"
    t.string   "otvetstv",     :limit => 50
    t.string   "comment",      :limit => nil
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "arxivs", :force => true do |t|
    t.string   "numrich",    :limit => nil
    t.string   "numses",     :limit => nil
    t.string   "numsoz",     :limit => nil
    t.string   "rada",       :limit => nil
    t.date     "dateprin"
    t.string   "shodo",      :limit => nil
    t.string   "comment",    :limit => nil
    t.string   "linkfile",   :limit => nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "mfile"
    t.string   "typefile"
    t.integer  "rada_id"
    t.integer  "pgo_id"
    t.integer  "person_id"
    t.string   "onadmin"
    t.string   "lseach"
  end

# Could not dump table "bankomat" because of following StandardError
#   Unknown type 'geometry' for column 'latlon'

# Could not dump table "boloto" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "books", :force => true do |t|
    t.integer  "num"
    t.date     "date_begin"
    t.date     "date_end"
    t.integer  "rada_id"
    t.string   "comment",    :limit => nil
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

# Could not dump table "cemetery" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "colodets" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "council_data" because of following StandardError
#   Unknown type 'geometry' for column 'st_centroid'

  create_table "councils", :force => true do |t|
    t.string   "name"
    t.string   "typ"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "telephon"
  end

# Could not dump table "councils_2" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "councils_gis" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "cover" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "dovidkas", :force => true do |t|
    t.integer  "number"
    t.date     "print"
    t.integer  "typ"
    t.integer  "komu"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geometry_columns", :id => false, :force => true do |t|
    t.string  "f_table_catalog",   :limit => 256, :null => false
    t.string  "f_table_schema",    :limit => 256, :null => false
    t.string  "f_table_name",      :limit => 256, :null => false
    t.string  "f_geometry_column", :limit => 256, :null => false
    t.integer "coord_dimension",                  :null => false
    t.integer "srid",                             :null => false
    t.string  "type",              :limit => 30,  :null => false
  end

  create_table "glossary_animals", :force => true do |t|
    t.string "name", :limit => 60
  end

  create_table "glossary_technics", :force => true do |t|
    t.string "name", :limit => 60
  end

# Could not dump table "hist" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "houses", :force => true do |t|
    t.integer  "pgo_id",         :limit => 8
    t.integer  "person_id",      :limit => 8
    t.date     "date_build"
    t.string   "material_wall",  :limit => 20
    t.string   "material_krovl", :limit => 20
    t.string   "comment",        :limit => nil
    t.boolean  "test"
    t.string   "comment_test",   :limit => nil
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "imgs", :force => true do |t|
    t.string   "linkfile"
    t.string   "typefile"
    t.binary   "mfile"
    t.integer  "arxiv_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "lands", :force => true do |t|
    t.integer  "pgo_id",     :limit => 8
    t.string   "comment",    :limit => nil
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string "Name",    :limit => 150
    t.string "mail",    :limit => 50
    t.string "address"
    t.string "comment", :limit => nil
  end

# Could not dump table "parcels" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "parcels_data" because of following StandardError
#   Unknown type 'geometry' for column 'centr'

  create_table "people", :force => true do |t|
    t.string   "famil"
    t.string   "name"
    t.string   "parent"
    t.integer  "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pers", :force => true do |t|
    t.integer  "pgo_id",              :limit => 8
    t.string   "surname",             :limit => 50
    t.string   "midname",             :limit => 50
    t.string   "name",                :limit => 50
    t.date     "borndate"
    t.boolean  "sex"
    t.string   "job",                 :limit => nil
    t.string   "s_all",               :limit => nil
    t.string   "s_build",             :limit => nil
    t.string   "s_osob_gosp",         :limit => nil
    t.string   "s_tov_gosp",          :limit => nil
    t.string   "s_arenda",            :limit => nil
    t.string   "s_pay",               :limit => nil
    t.date     "date_vibil"
    t.string   "prichina_vibil",      :limit => nil
    t.date     "date_vosvr"
    t.boolean  "full_vibil"
    t.string   "comment_full_vibil",  :limit => nil
    t.date     "date_regist"
    t.string   "address_pred_regist", :limit => nil
    t.boolean  "pensiya"
    t.boolean  "invalidnost"
    t.boolean  "soc_help"
    t.string   "comment_lgoti",       :limit => nil
    t.date     "date_begin_hoz"
    t.date     "date_end_hoz"
    t.string   "family",              :limit => 20
    t.string   "personal_account",    :limit => 50
    t.boolean  "test"
    t.string   "comment_test",        :limit => nil
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "address_reg",         :limit => nil
    t.date     "date_prib"
    t.string   "meta_prib",           :limit => nil
    t.date     "date_vib"
    t.integer  "count_men"
    t.date     "datezap"
    t.date     "date_vibil1"
    t.string   "prichina_vibil1",     :limit => nil
    t.date     "date_vosvr1"
  end

# Could not dump table "pgo_us" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "pgo_us1" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "pgos", :force => true do |t|
    t.integer  "book_id"
    t.integer  "num_1"
    t.integer  "num_2"
    t.string   "comment",      :limit => nil
    t.string   "otvetstv",     :limit => nil
    t.integer  "address_id",   :limit => 8
    t.date     "datezap"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.integer  "pgo_id",       :limit => 8
  end

# Could not dump table "poi" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "poin" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "posts", :force => true do |t|
    t.string "value", :limit => nil
  end

  create_table "prop_animals", :force => true do |t|
    t.integer  "animal_id",          :limit => 8
    t.integer  "value"
    t.integer  "glossary_animal_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "prop_houses", :force => true do |t|
    t.integer  "house_id",     :limit => 8
    t.string   "s",            :limit => nil
    t.string   "s_summer",     :limit => nil
    t.string   "s_jitlova",    :limit => nil
    t.integer  "n_room"
    t.boolean  "water"
    t.boolean  "kanaliz"
    t.boolean  "otoplen"
    t.boolean  "hot_water"
    t.boolean  "bath"
    t.boolean  "gas"
    t.boolean  "sgas"
    t.boolean  "el_plita"
    t.date     "datezap"
    t.string   "otvetstv",     :limit => nil
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "prop_lands", :force => true do |t|
    t.integer  "land_id",      :limit => 8
    t.date     "datezap"
    t.string   "s_all",        :limit => nil
    t.string   "s_build",      :limit => nil
    t.string   "s_osob_gosp",  :limit => nil
    t.string   "s_tov_gosp",   :limit => nil
    t.string   "s_arenda",     :limit => nil
    t.string   "s_senokos",    :limit => nil
    t.string   "s_ogorod",     :limit => nil
    t.string   "s_garden",     :limit => nil
    t.string   "s_sel_ugod",   :limit => nil
    t.string   "s_rill",       :limit => nil
    t.string   "s_bagat",      :limit => nil
    t.string   "s_sinojat",    :limit => nil
    t.string   "otvetstv",     :limit => nil
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "prop_technics", :force => true do |t|
    t.integer  "technic_id",          :limit => 8
    t.integer  "glossary_technic_id"
    t.integer  "value"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

# Could not dump table "road5" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "road_1" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "road_2" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "road_3" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "roads", :force => true do |t|
    t.integer "city_id"
    t.string  "value",   :limit => nil
    t.string  "typ",     :limit => 10
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "council_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sostav_radas", :force => true do |t|
    t.integer "rada_id"
    t.integer "post_id"
    t.string  "fio",     :limit => nil
  end

  create_table "spatial_ref_sys", :id => false, :force => true do |t|
    t.integer "srid",                      :null => false
    t.string  "auth_name", :limit => 256
    t.integer "auth_srid"
    t.string  "srtext",    :limit => 2048
    t.string  "proj4text", :limit => 2048
  end

# Could not dump table "sport" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "streets" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "technics", :force => true do |t|
    t.integer  "pgo_id",       :limit => 8
    t.date     "datezap"
    t.string   "otvetstv",     :limit => nil
    t.string   "comment",      :limit => nil
    t.boolean  "test"
    t.string   "comment_test", :limit => nil
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

# Could not dump table "trans" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
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
    t.string   "imya"
    t.string   "famil"
    t.string   "parent"
    t.string   "council_id"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

# Could not dump table "village_center" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "villages", :force => true do |t|
    t.string   "name_ukr"
    t.integer  "poshta"
    t.integer  "council_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "typ",        :limit => nil
  end

# Could not dump table "zabud" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

# Could not dump table "zatopl" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

end
