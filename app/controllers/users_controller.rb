class UsersController < InheritedResources::Base
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
	    respond_with(@user)  
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
	  if @user.update_attributes(params[:user])  
	    flash[:notice] = "Successfully updated user."  
	  end  
	  respond_with(@user)  
	end  

	def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end