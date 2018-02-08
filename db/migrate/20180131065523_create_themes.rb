class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
    	t.belongs_to :user
    	t.string :title
    	t.text :data
    	t.text :settings
      t.timestamps
    end
  end
end
