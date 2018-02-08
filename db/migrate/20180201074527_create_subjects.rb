class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.belongs_to :user
      t.string :title
      t.text :settings
      t.timestamps
    end
  end
end
