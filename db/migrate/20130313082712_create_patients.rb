class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :lastName
      t.string :firstName
      t.string :gender, :limit =>1 
      t.string :ethnicity
      t.date :dateOfBirth
      t.string :email, :null => false, :unique => true
      t.string :mobileNumber
      t.text :address
      t.string :phoneNumber
      t.text :notes
      t.string :identificationNumber, :limit => 20

      t.timestamps
    end

    add_index :patients, :lastName
    add_index :patients, :firstName
    add_index :patients, :identificationNumber, :unique => true
  end
end
