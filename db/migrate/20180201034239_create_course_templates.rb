class CreateCourseTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :course_templates do |t|
      t.belongs_to :course
      t.belongs_to :template
      t.datetime :expired_date
      t.text :settings, limit: 5.megabytes
      t.boolean :include_scores
      t.timestamps
    end

    add_index :course_templates, [:course_id, :template_id], unique: true
  end
end
