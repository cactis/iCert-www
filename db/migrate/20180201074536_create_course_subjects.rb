class CreateCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subjects do |t|
      t.belongs_to :course, null: false
      t.belongs_to :subject, null: false
      t.integer :credits
      t.text :settings
      t.timestamps
    end
  end
end
