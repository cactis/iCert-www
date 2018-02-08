class AddIndexesForImportsTables < ActiveRecord::Migration[5.1]
  def change
  	# add_column :cert_details, :id, :primary_key if ActiveRecord::Base.connection.table_exists? 'cert_details'
  	# add_column :cert_applies, :id, :primary_key if ActiveRecord::Base.connection.table_exists? 'cert_applies'
  end
end
