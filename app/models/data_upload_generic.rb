class DataUploadGeneric < ActiveRecord::Base
	attr_accessible :creator_id, :dataFile, :description, :metaData, :name, :patient_id, :type

	has_attached_file :dataFile

	belongs_to :patient
	belongs_to :creator, :class_name =>"User"
end
