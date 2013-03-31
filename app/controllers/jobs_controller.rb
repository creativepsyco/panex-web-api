class JobsController < ApplicationController

	def index
		puts "Enqueueing the job"
		Delayed::Job.enqueue AJob.new("text", Patient.find(:all).collect(&:email))
		respond_to do |format|
			format.html # "success"
			format.json { render text: "success" }
		end
	end
end
