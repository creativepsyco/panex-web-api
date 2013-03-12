# Help
# Refer to: http://blog.codebykat.com/2012/07/23/remote-api-authentication-with-rails-3-using-activeresource-and-devise/
# Inheriting from DeviseController
# See http://stackoverflow.com/questions/11634605/uninitialized-constant-devisecontrollersinternalhelpers
class SessionsController < DeviseController
	before_filter :authenticate_user!, :except => [:create, :destroy]
	# before_filter :ensure_params_exist
	respond_to :json

	def create
		resource = User.find_for_database_authentication(:email => params[:email])
		return invalid_login_attempt unless resource

		if resource.valid_password?(params[:password])
			sign_in(:user, resource)
			resource.ensure_authentication_token!
			render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email, :user_id=> resource.id, :resource=>resource}
			return
		end
		invalid_login_attempt
	end

	def destroy
		resource = User.find_for_database_authentication(:authentication_token => params[:auth_token])
		if not resource.nil?
			resource.authentication_token = nil
			resource.save
			render :json=> {:success=>true, :message=>"Session Destroyed", :status =>200 }
		else
			render :json=> {:success=>false, :message=>"Cannot Find user with given auth_token", :status =>404 }
		end

	end

	protected
	def ensure_params_exist
		return unless params[:user_login].blank?
		render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
	end

	def invalid_login_attempt
		render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
	end
end


# Testing
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET --data '{"auth_token":"WaEZrcHZqxWRYi8d5pmj"}' http://localhost:3000/users
#
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST --data '{"email": "abc@abc.com", "password":"password"}' http://localhost:3000/users/sign_in.json