class CreateAssets < ActiveRecord::Migration[5.1]
  create_table :assets do |t|
    t.belongs_to :user, index: true
    t.string :type, index: true
    t.belongs_to :assetable, polymorphic: true, index: true
    t.string :file
    t.text :settings
    t.timestamps
  end
end
