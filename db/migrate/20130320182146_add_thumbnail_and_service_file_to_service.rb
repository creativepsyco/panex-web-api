class AddThumbnailAndServiceFileToService < ActiveRecord::Migration
  def change
  	add_attachment :services, :serviceFile
  	add_attachment :services, :thumbnail
  end
end
