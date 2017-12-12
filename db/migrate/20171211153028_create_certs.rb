class CreateCerts < ActiveRecord::Migration[5.1]
  def change
    create_table :certs do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.string :title
      t.datetime :expired_date
      t.string :aasm_state
      t.timestamps
    end
  end
end
