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

ActiveRecord::Schema.define(:version => 20130823040850) do

  create_table "current_summations", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "meter_mac_id"
    t.datetime "timestamp"
    t.integer  "summation_delivered"
    t.integer  "summation_received"
    t.integer  "multiplier"
    t.integer  "divisor"
    t.integer  "digits_right"
    t.integer  "digits_left"
    t.boolean  "suppress_leading_zero"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "device_infos", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "install_code"
    t.string   "firmware_version"
    t.string   "hardware_version"
    t.string   "manufacturer"
    t.string   "model_id"
    t.string   "date_code"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "instantaneous_demands", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "meter_mac_id"
    t.datetime "timestamp"
    t.integer  "demand"
    t.integer  "multiplier"
    t.integer  "divisor"
    t.integer  "digits_right"
    t.integer  "digits_left"
    t.boolean  "suppress_leading_zero"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "meter_mac_id"
    t.datetime "timestamp"
    t.string   "text"
    t.boolean  "confirmation_required"
    t.boolean  "confirmed"
    t.integer  "queue"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "meter_infos", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "meter_mac_id"
    t.integer  "meter_type"
    t.string   "nick_name"
    t.string   "account"
    t.string   "auth"
    t.string   "host"
    t.boolean  "enabled"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "network_infos", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "coordinator_mac_id"
    t.integer  "status"
    t.string   "description"
    t.integer  "status_code"
    t.integer  "extended_pan_id"
    t.integer  "channel"
    t.integer  "short_address"
    t.integer  "link_strength"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "price_clusters", :force => true do |t|
    t.integer  "device_mac_id"
    t.integer  "meter_mac_id"
    t.datetime "timestamp"
    t.integer  "price"
    t.integer  "currency"
    t.integer  "trailing_digits"
    t.integer  "tier"
    t.string   "rate_label"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
