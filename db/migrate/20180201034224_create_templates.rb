class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.belongs_to :user
      t.string :title
      t.text :data
      t.text :settings
      t.timestamps
    end
  end
end
