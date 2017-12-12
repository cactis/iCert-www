class CreateUdollars < ActiveRecord::Migration[5.1]
  def change
    create_table :udollars do |t|
      t.belongs_to :user, index: true
      t.integer :payment
      t.integer :balance, limit: 4, default: 0
      t.string :title
      t.string :message
      t.timestamps
    end
  end
end
