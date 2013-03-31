require 'fastthread'

class ServiceRun < Struct.new(:inputFiles, :patient_id, :creator_id, :service_id, :extra_params)

	attr_accessible :output_dir, :input_dir, :log_text

	def enqueue(job)
		# Set the necessary class variables
		puts job
		Rails.logger.info 'newsletter_job/enqueue'
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
		x = 70*5
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
		Rails.logger.info 'newsletter_job/start'
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
end