# Help 
# Refer to: http://blog.codebykat.com/2012/07/23/remote-api-authentication-with-rails-3-using-activeresource-and-devise/
# Inheriting from DeviseController
# See http://stackoverflow.com/questions/11634605/uninitialized-constant-devisecontrollersinternalhelpers
class SessionsController < DeviseController
	respond_to :json
	prepend_before_filter :require_no_authentication, :only => [:create ]
	
	def create
		build_resource
		resource = User.find_for_database_authentication(:email => params[:email])
		return invalid_login_attempt unless resource

		if resource.valid_password?(params[:password])
			resource.ensure_authentication_token!  #make sure the user has a token generated
			render :json => { :authentication_token => resource.authentication_token,
			:user_id => resource.id },
			:status => :created
			return
		end
	end

	def destroy
		# expire auth token
		@user=User.where(:authentication_token=>params[:auth_token]).first
		@user.reset_authentication_token!
		# sign_out(user);
		render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
	end

	def invalid_login_attempt
		warden.custom_failure!
		render :json => { :errors => ["Invalid email or password."] },  :success => false, :status => :unauthorized
	end
end
