class CustomersController < InheritedResources::Base
	#devise user authentication. 
	before_filter :authenticate_user!

	def index
		@customers = Customer.all
	end

	def new
		@customer = Customer.new
		@customer.addresses.build
	end

	def show
		@customer = Customer.find(params[:id])
		@customers = Customer.find(params[:id])
	end

	def edit  
	    @customer = Customer.find(params[:id])  
	    respond_with(@customer)  
	  end 

	  def create
	    @customer = Customer.new(customer_params)
	    if @customer.save
	      redirect_to @customer, notice: 'Customer was successfully created.'
	    else
	      render action: 'new'
	    end
	  end

	def update  
		@customer = Customer.find(params[:id])  
			if @customer.update_attributes(params[:customer])  
				flash[:notice] = "Successfully updated customer."  
			end  
		respond_with(@customer)  
	end  

	def customer_params
      params.require(:customer).permit(:id, :organization, :customer_name, :customer_email, :customer_phone, :account_id, :user_id, :order_id,
      									:addresses_attributes => [:id, :line_one, :line_two, :city, :state, :zip])
    end
end