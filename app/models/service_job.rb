class ServiceJob < ActiveRecord::Base
  attr_accessible :creator_id, :inputDir, :outputDir, :patient_id, :service_id
end
