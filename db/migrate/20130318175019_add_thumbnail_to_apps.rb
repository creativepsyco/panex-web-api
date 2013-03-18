class AddThumbnailToApps < ActiveRecord::Migration
  def change
    add_column :apps, :thumbnail, :attachment
  end
end
