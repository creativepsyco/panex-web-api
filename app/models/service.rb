class Service < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	attr_accessible :creator_id, :description, :helpLink, :name, :version, :thumbnail, :serviceFile, :commandLine

	has_attached_file :thumbnail,
	:styles => { :medium => "300x300>", :thumb => "100x100>" },
	:default_url => "/images/:style/missing.png"

	has_attached_file :serviceFile
end
