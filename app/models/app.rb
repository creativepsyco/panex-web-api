class App < ActiveRecord::Base
	belongs_to :user
	attr_accessible :description, :helpLink, :name, :user_id, :version, :thumbnail, :appFile

	has_attached_file :thumbnail,
	:styles => { :medium => "300x300>", :thumb => "100x100>" },
	:default_url => "/images/:style/missing.png"

	has_attached_file :appFile
end
