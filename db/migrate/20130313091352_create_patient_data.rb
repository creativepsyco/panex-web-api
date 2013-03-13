class CreatePatientData < ActiveRecord::Migration
  def change
    create_table :patient_data do |t|
      t.attachment :data
      t.text :remarks
      t.text :thumbnail
      t.text :condition

      t.timestamps
    end
  end
end
