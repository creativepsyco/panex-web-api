require 'fastthread'

class AJob < Struct.new(:text, :emails)

	def enqueue(job)
		Rails.logger.info 'newsletter_job/enqueue'
	end

	def perform
		x = 10*5
		m = 0
		t = Thread.new do
			while m < x do
				puts "performing task"
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
		# Airbrake.notify(exception)
	end

	def failure
		# page_sysadmin_in_the_middle_of_the_night
	end
end