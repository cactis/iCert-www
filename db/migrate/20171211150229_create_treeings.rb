class CreateTreeings < ActiveRecord::Migration[5.1]
  def change
    create_table :treeings do |t|
      t.string :type, index: true
      t.belongs_to :tree, polymorphic: true, index: true
      t.belongs_to :treeable, polymorphic: true, index: true
      t.integer :value
      t.text :settings
      t.timestamps
    end


    # add_index :treeings, [:tree_type, :tree_id]
    # add_index :treeings, [:treeable_type, :treeable_id]
    # add_index :treeings, [:tree_type, :tree_id, :treeable_type, :treeable_id], unique: true
  end
end
