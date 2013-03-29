class ChangeNameToCondition < ActiveRecord::Migration
	def change
		rename_column :data_upload_generics, :name, :condition
	end
end
