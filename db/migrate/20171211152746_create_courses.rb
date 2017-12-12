class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.boolean :has_cert
      t.integer :hours
      t.integer :percentage
      t.datetime :start_date
      t.datetime :end_date
      t.string :aasm_state
      t.timestamps
    end
  end
end
