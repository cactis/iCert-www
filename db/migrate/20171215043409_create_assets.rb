class CreateAssets < ActiveRecord::Migration[5.1]
		def change
	  create_table :assets do |t|
	  	# remove_index :assets, :index_assets_on_user_id if ActiveRecord::Base.connection.index_exists?(:assets, :index_assets_on_user_id)
	    t.belongs_to :user, index: true
	    t.string :type, index: true
	    t.belongs_to :assetable, polymorphic: true, index: true
	    t.string :file
	    t.text :settings
	    t.timestamps
	  end
	end
end
