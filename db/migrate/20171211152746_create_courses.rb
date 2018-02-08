class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.belongs_to :cert_detail
      t.string :title
      t.boolean :has_cert
      t.integer :hours
      t.integer :percentage
      t.datetime :start_date
      t.datetime :end_date
      t.string :aasm_state
      t.text :settings
      t.timestamps
    end
  end
end
