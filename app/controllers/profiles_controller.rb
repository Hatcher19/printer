class ProfilesController < InheritedResources::Base


	def new
		@profile = Profile.new
		@profile.users.build
	end

	def create
		@profile = Profile.new(profile_params)
			if @profile.save
				@user = @profile.users.create(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation], :profile_id => params[:profile_id] )
				sign_in(@user)
				redirect_to @user, notice: 'Account was successfully created.'
			else
				render action: 'new'
			end
	end

	def update
		@profile = Profile.find(params[:id])

		if @profile.update_attributes(profile_params)
			redirect_to profile_path, notice:  "Your account has been successfully updated."
		else
			render action: "edit"
		end
	end 

	def profile_params
        params.require(:profile).permit(:id, :company,
      								  :users_attributes => [:id, :email, :password, :password_confirmation, :profile_id, :created_at, :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip, :sign_in_count, :updated_at])
	end
end