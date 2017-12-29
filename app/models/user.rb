class User < ApplicationRecord
  extend UserExtend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :certs

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  def self.seed_params(index = 0)
    {
      name: Faker::Name.name,
      email: "user#{index}@sce.pccu.edu.tw",
      password: '12345678',
      password_confirmation: '12345678'
    }
  end

  def push!(message = {title: "title", body: "body"}, data = {})
    devices = [
      #{ }"c1e79203a5b0b37d2f8789bf246c27a9f6f162c4e45bb1a325d59eb9d7332557", # PL
      #{ }"33a52d6009d1e2551f82ffe79f74a9f800646c2a170e5df0d133384a4567e2d5", #YJ
      # "b3dedd420900dde92823a34a47d1d6d9e2ea37fb25bf3bb64ec8680433f983e4", # Eric
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
