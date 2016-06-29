class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def authenticate_active_admin_user!
		authenticate_user!
		unless current_user.has_role? :admin
	    	flash[:alert] = "You are not authorized to access this resource!"
	    	redirect_to root_path
		end
	end

	def after_sign_in_path_for(resource)
		if resource.is_a?(User)
			if User.count == 1
				resource.add_role 'admin'
			end
			resource
		end
		root_path
	end
end