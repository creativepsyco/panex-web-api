class DataUploadGeneric < ActiveRecord::Base
	attr_accessible :creator_id, :dataFile, :description, :metaData, :condition, :patient_id, :dataType

	has_attached_file :dataFile

	belongs_to :patient
	belongs_to :creator, :class_name =>"User"
end
