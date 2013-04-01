class CreateServiceJobs < ActiveRecord::Migration
  def change
    create_table :service_jobs do |t|
      t.string :inputDir
      t.string :outputDir
      t.integer :creator_id
      t.integer :patient_id
      t.integer :service_id

      t.timestamps
    end
  end
end
