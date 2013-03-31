require 'fastthread'

class AJob < Struct.new(:text, :emails)

	def enqueue(job)
		puts job
		Rails.logger.info 'newsletter_job/enqueue'
	end

	def perform
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
		# emails.each { |e| NewsletterMailer.deliver_text_to_email(text, e) }
	end

	def before(job)
		Rails.logger.info 'newsletter_job/start'
	end

	def after(job)
		Rails.logger.info 'newsletter_job/after'
	end

	def success(job)
		Rails.logger.info 'newsletter_job/success'
	end

	def error(job, exception)
		puts exception
		# Airbrake.notify(exception)
	end

	def failure
		puts "Error Encountered"
		# page_sysadmin_in_the_middle_of_the_night
	end
end