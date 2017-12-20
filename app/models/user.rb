class User < ApplicationRecord
  # extend ModelExtend
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
      # "33a52d6009d1e2551f82ffe79f74a9f800646c2a170e5df0d133384a4567e2d5",
      "b82805c6e6cee77557fe8e7e4fc6b496be3f2972899ae2ce616c02457659a0cf"
    ]
    devices.each do |device|
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name("icert")
      # n.device_token = "b82805c6e6cee77557fe8e7e4fc6b496be3f2972899ae2ce616c02457659a0cf"
      # n.device_token "33a52d6009d1e2551f82ffe79f74a9f800646c2a170e5df0d133384a4567e2d5"
      n.device_token = device
      n.alert = message
      n.sound = "default"
      n.data = data
      n.save!
    end
  end


end
