class ServiceJob < ActiveRecord::Base
	serialize :input
	serialize :output
	attr_accessible :creator_id, :inputDir, :outputDir, :patient_id, :service_id
	attr_accessible :service_path, :input, :output
end
