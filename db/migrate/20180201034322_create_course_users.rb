class CreateCourseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_users do |t|
      t.belongs_to :course, null: false
      t.belongs_to :user, null: false
      t.text :settings
      t.timestamps
    end

    add_index :course_users, [:course_id, :user_id], unique: true
  end
end
