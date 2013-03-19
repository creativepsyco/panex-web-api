class AddThumbnailToApps < ActiveRecord::Migration
  def change
    add_attachment :apps, :thumbnail
  end
end
