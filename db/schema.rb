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

ActiveRecord::Schema.define(:version => 20130326161119) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.string   "helpLink"
    t.string   "version"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.string   "appFile_file_name"
    t.string   "appFile_content_type"
    t.integer  "appFile_file_size"
    t.datetime "appFile_updated_at"
  end

  create_table "data_upload_generics", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "creator_id"
    t.integer  "patient_id"
    t.string   "dataFile_file_name"
    t.string   "dataFile_content_type"
    t.integer  "dataFile_file_size"
    t.datetime "dataFile_updated_at"
    t.string   "type"
    t.string   "metaData"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "patients", :force => true do |t|
    t.string   "lastName"
    t.string   "firstName"
    t.string   "gender",               :limit => 1
    t.string   "ethnicity"
    t.date     "dateOfBirth"
    t.string   "email",                              :null => false
    t.string   "mobileNumber"
    t.text     "address"
    t.string   "phoneNumber"
    t.text     "notes"
    t.string   "identificationNumber", :limit => 20
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "patients", ["firstName"], :name => "index_patients_on_firstName"
  add_index "patients", ["identificationNumber"], :name => "index_patients_on_identificationNumber", :unique => true
  add_index "patients", ["lastName"], :name => "index_patients_on_lastName"

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "creator_id"
    t.string   "version"
    t.string   "helpLink"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "serviceFile_file_name"
    t.string   "serviceFile_content_type"
    t.integer  "serviceFile_file_size"
    t.datetime "serviceFile_updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.string   "commandLine",              :default => "", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",          :null => false
    t.string   "encrypted_password",     :default => "",          :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "authentication_token"
    t.string   "role",                   :default => "clinician"
    t.string   "name",                   :default => "",          :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
