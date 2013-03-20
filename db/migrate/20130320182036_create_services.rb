class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.integer :creator_id
      t.string :version
      t.string :helpLink

      t.timestamps
    end
  end
end
