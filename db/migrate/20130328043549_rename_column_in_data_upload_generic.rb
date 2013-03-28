class RenameColumnInDataUploadGeneric < ActiveRecord::Migration
  def up
  	 rename_column :data_upload_generics, :type, :dataType
  end

  def down
  end
end
