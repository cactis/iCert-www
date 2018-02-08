class CreateCourseUserSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_user_subjects do |t|
      t.belongs_to :course_user, null: false
      t.belongs_to :course_subject, null: false
      t.integer :score
      t.text :settings
      t.timestamps
    end
  end
end
