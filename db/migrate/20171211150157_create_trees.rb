class CreateTrees < ActiveRecord::Migration[5.1]
  create_table :trees do |t|
    t.string :type, index: true
    t.belongs_to :user, index: true
    t.string :name, null: false
    t.string :title
    t.string :alias

    t.integer :parent_id, null: true, index: true
    t.integer :lft, null: false, index: true
    t.integer :rgt, null: false, index: true
    t.integer :depth, null: false, default: 0
    t.integer :children_count, null: false, default: 0
    t.integer :ancestors_count, null: false, default: 0
    t.integer :descendants_count, null: false, default: 0

    t.boolean :active, :default => 1

    t.text :settings
    t.timestamps

    t.index [:type, :parent_id, :name], unique: true
  end
end
