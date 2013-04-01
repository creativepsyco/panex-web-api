class JobsController < ApplicationController

	def index
		puts "Enqueueing the job"
		Delayed::Job.enqueue AJob.new("text", Patient.find(:all).collect(&:email))
		respond_to do |format|
			format.html # "success"
			format.json { render text: "success" }
		end
	end

	def test_service_run
		service_id = params[:service_id]
		@aServiceJob = ServiceJob.new
		@aServiceJob.inputDir = ''
		@aServiceJob.outputDir = ''
		@aServiceJob.patient_id = 1
		@aServiceJob.creator_id = 1

		@aServiceJob.save

		aServiceRun = ServiceRun.new(DataUploadGeneric.find_all_by_patient_id(1), 1, 1, service_id, "", @aServiceJob.id)
		# Files must belong to the same patient
		Delayed::Job.enqueue aServiceRun
		respond_to do |format|
			format.html # "success"
			format.json { render json: aServiceRun, :status => 200 } 
		end
	end
end
