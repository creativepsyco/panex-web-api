class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :helpLink
      t.string :version

      t.timestamps
    end
  end
end
