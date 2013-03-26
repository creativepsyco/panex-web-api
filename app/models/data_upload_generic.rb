class DataUploadGeneric < ActiveRecord::Base
  attr_accessible :creator_id, :dataFile, :description, :metaData, :name, :patient_id, :type
end
