class AccountsController < InheritedResources::Base
skip_before_filter :trial_expired

	def new
		@account = Account.new
		@account.users.build
	end

	def create
		@account = Account.new(account_params)
	    @account.trial_end_date = Date.today + 30.days
	    @account.trial_upgraded = false
			if @account.save
				@user = @account.users.create(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation], :account_id => params[:account_id], :role => params[:role], :first_name => params[:first_name], :last_name => params[:last_name], :phone_number => params[:phone_number] )
				sign_in(@user)
				redirect_to @user, notice: 'Account was successfully created.'
			else
				render action: 'new'
			end
	end

	def update
		@account = Account.find(params[:id])

		if @account.update_attributes(account_params)
			redirect_to account_path, notice:  "Your account has been successfully updated."
		else
			render action: "edit"
		end
	end 

	def account_params
        params.require(:account).permit(:id, :subdomain, :trial_end_date,
      								  :users_attributes => [:id, :email, :password, :password_confirmation, :profile_id, :created_at, :current_sign_in_at, :current_sign_in_ip, :last_sign_in_at, :last_sign_in_ip, :sign_in_count, :updated_at, :role, :first_name, :last_name, :phone_number])
	end
end