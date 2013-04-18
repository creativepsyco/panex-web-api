class AddOutputTextToServiceJob < ActiveRecord::Migration
  def change
  	change_table :service_jobs do |t|
  		t.text :ouput
  	end
  end
end
