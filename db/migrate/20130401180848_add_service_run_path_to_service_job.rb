class AddServiceRunPathToServiceJob < ActiveRecord::Migration
  def change
  	change_table :service_jobs do |t|
  		t.string :service_path, :null => false, :default => ""
  	end
  end
end
