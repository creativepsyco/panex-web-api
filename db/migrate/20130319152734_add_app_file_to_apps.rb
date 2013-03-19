class AddAppFileToApps < ActiveRecord::Migration
  def change
  	  add_attachment :apps, :appFile
  end
end
