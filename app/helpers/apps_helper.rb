module AppsHelper
	def generate_zip(app)
		send_file "#{Rails.root}/public#{app.appFile.url(:original, false)}"
	end
end
