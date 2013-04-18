class AddTextToServiceJob < ActiveRecord::Migration
  def change
  	change_table :service_jobs do |t|
  		t.text :input
  	end
  end
end
