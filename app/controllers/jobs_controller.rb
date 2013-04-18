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
		@aServiceJob = ServiceJob.new
		@aServiceJob.service_id = params[:service_id]
		@aServiceJob.inputDir = ''
		@aServiceJob.outputDir = ''
		@aServiceJob.patient_id = params[:patient_id]
		@aServiceJob.creator_id = params[:user_id]

		inputFiles = []

		params[:input].each do |item|
			if item[:dataType] == "GENERIC"
				@aItem = DataUploadGeneric.find(item[:id])
				inputFiles.push(@aItem)
			end
		end

		@aServiceJob.save

		extra_params = ""

		aServiceRun = ServiceRun.new(inputFiles, @aServiceJob.patient_id, @aServiceJob.creator_id, @aServiceJob.service_id, extra_params, @aServiceJob.id)
		# Files must belong to the same patient
		Delayed::Job.enqueue aServiceRun
		respond_to do |format|
			format.html # "success"
			format.json { render json: aServiceRun, :status => 200 }
		end
	end

	def run_service
		@aServiceJob = ServiceJob.new
		@aServiceJob.service_id = params[:service_id]
		@aServiceJob.inputDir = ''
		@aServiceJob.outputDir = ''
		@aServiceJob.patient_id = params[:patient_id]
		@aServiceJob.creator_id = params[:user_id]

		inputFiles = []

		params[:input].each do |item|
			if item[:dataType] == "GENERIC"
				@aItem = DataUploadGeneric.find(item[:id])
				inputFiles.push(@aItem)
			end
		end

		@aServiceJob.input = inputFiles
		@aServiceJob.save

		extra_params = ""

		aServiceRun = ServiceRun.new(inputFiles, @aServiceJob.patient_id, @aServiceJob.creator_id, @aServiceJob.service_id, extra_params, @aServiceJob.id)
		# Files must belong to the same patient
		Delayed::Job.enqueue aServiceRun
		respond_to do |format|
			format.html # "success"
			format.json { render json: aServiceRun, :status => 200 }
		end
	end
end
