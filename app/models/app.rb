class App < ActiveRecord::Base
	belongs_to :user
	attr_accessible :description, :helpLink, :name, :user_id, :version
end
