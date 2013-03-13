class PatientData < ActiveRecord::Base
	include Paperclip::Glue
  attr_accessible :condition, :data, :remarks, :thumbnail

  has_attached_file :data

  belongs_to :patient
end
