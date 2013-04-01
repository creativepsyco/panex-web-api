require 'fastthread'
require 'fileutils'
require 'zip/zipfilesystem'

class ServiceRun < Struct.new(:inputFiles, :patient_id, :creator_id, :service_id, :extra_params, :service_job_id)

	def enqueue(job)
		# Set the necessary class variables
		# Including input and output dirs
		generic_path ="/tmp/#{patient_id}_#{service_id}_#{Time.now.to_i}"
		output_dir = "#{generic_path}/output"
		input_dir = "#{generic_path}/input"

		Delayed::Worker.logger.info "ServiceRun/Enqueued Input Dir #{input_dir} output dir: #{output_dir}"

		# Create necessary dirs
		FileUtils.mkdir_p output_dir
		FileUtils.mkdir_p input_dir

		Delayed::Worker.logger.debug job
		Delayed::Worker.logger.info "ServiceRun Job enqueued"
		@aServiceJob = ServiceJob.find(service_job_id)
		@aServiceJob.inputDir = input_dir
		@aServiceJob.outputDir = output_dir
		@aServiceJob.service_path = generic_path
		@aServiceJob.save
		Delayed::Worker.logger.info "ServiceJob Saved"
	end

	def perform
		Delayed::Worker.logger.info "[ServiceRun] Beginning execution of the perform stage"

		@service = Service.find(service_id)
		command_line = @service.commandLine

		@serviceJob = ServiceJob.find(service_job_id)
		generic_path = @serviceJob.service_path
		input_dir = @serviceJob.inputDir
		output_dir = @serviceJob.outputDir
		Dir.chdir(generic_path)
		puts generic_path, command_line, input_dir, output_dir
		system("#{command_line} #{input_dir} #{output_dir}")
		# system(command_line, input_dir, output_dir)

		Delayed::Worker.logger.info "[ServiceRun] Finished execution of the perform stage"
	end

	def before(job)
		# Check out the files and put them in a temp dir
		# Check out the service zip file and unzip in same dir
		# Apply Chmod to it
		# Run the file .setup line by line
		@aServiceJob = ServiceJob.find(service_job_id)
		input_dir = @aServiceJob.inputDir
		generic_path = @aServiceJob.service_path

		Delayed::Worker.logger.info "[ServiceRun Before] Processing Copying of Input Files"
		inputFiles.each do |aFile|
			# Copy Generic Uploaded Files
			if aFile.dataType == "GENERIC"
				Delayed::Worker.logger.debug "[ServiceRun] Processing GENERIC Type of Data"
				begin
					file_name = File.join(input_dir, aFile.dataFile.original_filename)
				rescue => ex
					puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
				end
				if File.exists? file_name
					# Change the file name in destination folder
					dest_path = File.join input_dir, File.basename(aFile.dataFile.path,File.extname(aFile.dataFile.path)), Time.now.to_i
					Delayed::Worker.logger.debug "File Exists Destination Path: #{dest_path}"
					FileUtils.copy_file aFile.dataFile.path, dest_path
				else
					FileUtils.cp aFile.dataFile.path, input_dir
				end
			end
			# Handle Other Types of Files

			# Do for the rest of the file types
		end # inputFile Copy loop
		Delayed::Worker.logger.info "[ServiceRun] File Copy Phase has been Finished"
		Delayed::Worker.logger.info "[ServiceRun] initializing Service Copy Phase"
		@service = Service.find(service_id)
		unzip_file(@service.serviceFile.path, generic_path)
		Delayed::Worker.logger.info "[ServiceRun] Finished Service Copy Phase"
	end

	def after(job)
		# Clean the temporary directory
		Rails.logger.info 'newsletter_job/after'
	end

	def success(job)
		# Check the files in the output dir
		# Add it to the database as result
		# Trigger a notification to be sent to the creator_id
		@aServiceJob = ServiceJob.find(service_job_id)
		output_dir = @aServiceJob.outputDir
		generic_path = @aServiceJob.service_path
		# Create Entries based on a file's behaviour
		Delayed::Worker.logger.info "[ServiceRun] initializing Success Handling phase"
		Dir.foreach(output_dir) do |item|
			next if item == '.' or item == '..'
			# do work on real items
			Delayed::Worker.logger.info "[ServiceRun Success] Proessing #{item}"
			name = File.basename(item)
			abs_output_path = "#{output_dir}/#{name}"
			file_ext = File.extname(name)
			if file_ext.downcase == ".jpg" or file_ext.downcase == ".png"
				Delayed::Worker.logger.info "Processing GENERIC File"
				upload_data = {
					:creator_id => creator_id,
					:patient_id => patient_id,
					:condition => "GENERATED FILE",
					:dataType => "GENERIC",
					:description => "This is generated",
					:metaData => ""
				}
				@aData = DataUploadGeneric.new(upload_data)
				thisFile = File.open(abs_output_path)
				@aData.dataFile = thisFile
				thisFile.close
				if @aData.save
					Delayed::Worker.logger.debug "#{abs_output_path} successfully saved in DB"
				end
			end
		end
		# Trigger Notification
		
		Delayed::Worker.logger.info "[ServiceRun] Finishing up Success Handling Phase"
	end

	def error(job, exception)
		# Notification to developer and creator
		puts exception
		# Airbrake.notify(exception)
	end

	def failure
		puts "Error Encountered"
		# page_sysadmin_in_the_middle_of_the_night
	end

	def unzip_file (file, destination)
		Zip::ZipFile.open(file) { |zip_file|
			zip_file.each { |f|
				f_path=File.join(destination, f.name)
				FileUtils.mkdir_p(File.dirname(f_path))
				if File.exist?(f_path)
					FileUtils.rm_rf(f_path)
				end
				zip_file.extract(f, f_path) unless File.exist?(f_path)
				puts "Unzipping File #{f_path}"
			}
		}
	end
end