class CreateCerts < ActiveRecord::Migration[5.1]
  def change
    create_table :certs do |t|
      t.belongs_to :course_user, null: false
      t.belongs_to :course_template, null: false
      t.string :title
      t.datetime :expired_date
      t.string :aasm_state
      t.string :qrcode_token, index: true
      t.datetime :qrcode_token_at
      t.string :blockchain_token
      # t.belongs_to :user
      # t.belongs_to :course
      t.text :settings
      t.timestamps
    end

    add_index :certs, [:course_template_id, :course_user_id], unique: true
  end
end
