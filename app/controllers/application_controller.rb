class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :trial_expired, :except => [:user]

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied."
		redirect_to root_url
	end

	def trial_expired
		if user_signed_in?
			if current_user.account.trial_upgraded == false
				if (current_user.account.trial_end_date - Date.today).to_i < 0
					redirect_to user_path(current_user)
				end
			end
		end
	end
end
