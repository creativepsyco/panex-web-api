class CreateDataUploadGenerics < ActiveRecord::Migration
  def change
    create_table :data_upload_generics do |t|
      t.string :name
      t.string :description
      t.integer :creator_id
      t.integer :patient_id
      t.attachment :dataFile
      t.string :type
      t.string :metaData

      t.timestamps
    end
  end
end
