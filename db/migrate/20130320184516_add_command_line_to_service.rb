class AddCommandLineToService < ActiveRecord::Migration
  def change
  	change_table :services do |t|
  		t.string :commandLine, :null => false, :default => ""
  	end
  end
end
