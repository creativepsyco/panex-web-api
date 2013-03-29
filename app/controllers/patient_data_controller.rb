class PatientDataController < ApplicationController

	include AppsHelper

	before_filter :authenticate_user!, :except => [:index]
	before_filter :ensure_params_exist, :except => [:index, :index_all, :download]
	respond_to :json

	def index
		puts "patient_data#index fired"
		@patient = Patient.find(params[:patient_id])
		if @patient.nil?
			render :json => {:success => false, :message => "missing or incorrect patient_id entered"}, :status => 422
			return
		end

		# Get the generic data first
		@generic_data = DataUploadGeneric.find_all_by_patient_id(params[:patient_id])
		render :json => {:success => true, :data=> @generic_data }, :status => 200
	end

	def index_all
		puts "patient_data#index_all fired"
		# Get the generic data first
		@generic_data = DataUploadGeneric.all
		render :json => {:success => true, :data=> @generic_data }, :status => 200
	end

	# required params
	# Patient_id
	# DataType
	# File Id
	def download
		# Ensure that the params exist
		if params[:dataType].blank? 
			# Bad Request
			render :json => {:success => false, :message=> "Please specify the dataType of the file."}, :status => 400
			return 
		end
		if params[:dataType] == "GENERIC"
			# Handle download for generic type
			@theFile = DataUploadGeneric.find(params[:file_id])
			if @theFile.nil?
				render :json => {:success => false, :message => "Cannot find the file with the specified file_id" }, :status => 404
				return
			end 
			send_file @theFile.dataFile.path
			return
		end
		render :json => {:success => false, :message => "Error with request" }, :status => 422
	end

	##
	# handles upload of data
	# POST /patients/patients_id/patient_data/upload
	##
	def upload
		# calls different registered data types
		# and creates and saves various different
		# types of data files and associates them
		# to the patient id
		# puts params

		@patient = Patient.find(params[:patient_id])

		if @patient.nil?
			render :json => {:success => false, :message => "missing or incorrect patient_id entered"}, :status => 422
			return
		end

		success = true
		total_success = 0

		@files = params[:files]
		# TODO: do some kind of validation before saving all
		# XXX: Rollback feature?
		index = 0;
		@files.each do |aFile|

			puts params[:files]["#{index}"].content_type
			content_type = params[:files]["#{index}"].content_type
			if not content_type == "dicom"
				# Content is not dicom
				file_data = {
					:creator_id => params[:creator_id],
					:description => params[:description],
					:dataType => "GENERIC",
					:condition => params[:condition],
					:patient_id => @patient.id,
					:metaData => "",
					:dataFile => params[:files]["#{index}"]
				}
				@genericFile = DataUploadGeneric.new(file_data)
				if @genericFile.save
					total_success += 1
				else
					success = false
				end
			end
			index += 1
		end

		if success
			render :json => {:success => true, :message => "Successfully uploaded the items"}, :status => 200
		else
			render :json => {:success => false, :message => "Uploading of data caused some error"}, :status => 422
		end
	end

	protected
	def ensure_params_exist
		return unless params[:creator_id].blank?
		render :json=>{:success=>false, :message=>"missing user_id"}, :status=>422
	end

	def send_error_json
		render :json => {:success => false, :message => "Error with the request check params"}, :status=>422
	end
end
