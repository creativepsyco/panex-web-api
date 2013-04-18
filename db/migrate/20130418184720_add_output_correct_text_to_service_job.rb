class AddOutputCorrectTextToServiceJob < ActiveRecord::Migration
  def change
  	change_table :service_jobs do |t|
  		t.text :output
  	end
  end
end
