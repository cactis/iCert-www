class User < ApplicationRecord
  extend UserExtend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_many :certs

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def self.is_admin?
    # log User.current_id, 'User.current_id'
    User.current_id == User.first.id
  end

  def self.seed_params
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: '12345678',
      password_confirmation: '12345678'
    }
  end

  def push!(message = {title: "title", body: "body"}, data = {})
    devices = [
      #{ }"c1e79203a5b0b37d2f8789bf246c27a9f6f162c4e45bb1a325d59eb9d7332557", # PL
      #{ }"33a52d6009d1e2551f82ffe79f74a9f800646c2a170e5df0d133384a4567e2d5", #YJ
      # "b3dedd420900dde92823a34a47d1d6d9e2ea37fb25bf3bb64ec8680433f983e4", # Eric
      # "9748c12c841460bc4b2d19247ca322ebb6dac868c67ca803e45045eeecf860bd", #Stars
      "b82805c6e6cee77557fe8e7e4fc6b496be3f2972899ae2ce616c02457659a0cf"
    ]
    devices.each do |device|
      n = Rpush::Apns::Notification.new
      # n.app = Rpush::Apns::App.find_by_name("icert")
      n.app = Rpush::Apns::App.where(name: 'icert').first
      # n.device_token = "b82805c6e6cee77557fe8e7e4fc6b496be3f2972899ae2ce616c02457659a0cf"
      # n.device_token "33a52d6009d1e2551f82ffe79f74a9f800646c2a170e5df0d133384a4567e2d5"
      n.device_token = device
      n.alert = message
      n.sound = "default"
      n.data = data
      n.save!
      # Rpush.embed
    end
    # Rpush.push
  end


end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  token                  :string(255)
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  aasm_state             :string(255)
#  settings               :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
