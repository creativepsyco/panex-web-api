class AddProducedByColumnToDataUpload < ActiveRecord::Migration
  def change
  	change_table :data_upload_generics do |t|
  		t.integer :service_id
  	end
  end
end
