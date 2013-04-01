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
		# Run the binary as
		# 	binary [inputDir] [outputDir]
		# With help from the system command and not Thread
		# We don't care about the processes spawned by the
		# Binary itself
		#
		# An example:
		# 	system("mv #{@SOURCE_DIR}/#{my_file} #{@DEST_DIR}/#{file})
		# Additionaly also maintain a log file
		x = 4*5
		m = 0
		t = Thread.new do
			while m < x do
				puts "performing task #{m}"
				sleep 5
				m += 5
			end
		end

		puts "I am being performed"
		t.join
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
			# Handle Other Types of File

			# Do for the rest of the file types
		end # inputFile Copy loop
		Delayed::Worker.logger.info "[ServiceRun] File Copy Phase has been Finished"
		Delayed::Worker.logger.info "[ServiceRun] initializing Service Copy Phase"
		@service = Service.find(service_id)
		unzip_file(@service.serviceFile.path, generic_path)
		Delayed::Worker.logger.info "[ServiceRun] Finished Service Copy Phase "
	end

	def after(job)
		# Clean the temporary directory
		Rails.logger.info 'newsletter_job/after'
	end

	def success(job)
		# Check the files in the output dir
		# Add it to the database as result
		# Trigger a notification to be sent to the creator_id
		Rails.logger.info 'newsletter_job/success'
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