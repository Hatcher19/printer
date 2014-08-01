class UsersController < InheritedResources::Base
	before_filter :new_user, :only => [:new, :create]

	load_and_authorize_resource

	def new_user
	@user = User.new(user_params)
	end

	def index
		@users = User.all
	end

	def new
		@user = User.new
		# @order.line_items.build
		# @order.artworks.build
	end

	def show
		@user = User.find(params[:id])
	end

	def edit  
	    @user = User.find(params[:id])
	end 

	def create
	    @user = User.new(user_params)
	    if @user.save
	      redirect_to @user, notice: 'User was successfully created.'
	    else
	      render action: 'new'
	    end
	  end

	def update  
	  @user = User.find(params[:id])  
	  if @user.update_attributes(user_params)  
	    flash[:notice] = "Successfully updated user."  
	  end  
	  respond_with(@user)  
	end  

	def user_params
      params.fetch(:user).permit(:email, :password, :password_confirmation, :account_id, :role, :first_name, :last_name, :phone_number, :braintree_customer_id) if params[:user]
    end
end