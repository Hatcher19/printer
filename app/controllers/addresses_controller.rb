class AddressesController < InheritedResources::Base
	def index
		@addresses = Address.all
	end

	def new
		@address = Address.new
	end

	def show
		@address = Address.find(params[:id])
		@addresses = Address.find(params[:id])
	end

	def edit  
	    @address = Address.find(params[:id])  
	    respond_with(@address)  
	  end 

	  def create
	    @address = Address.new(address_params)
	    if @address.save
	      redirect_to @address
	    else
	      render action: 'new'
	    end
	  end

	def update  
	  @address = Address.find(params[:id])  
	  if @address.update_attributes(params[:address])  
	    # flash[:notice] = "Successfully updated customer."  
	  end  
	  respond_with(@address)  
	end  

	def address_params
      params.require(:address).permit(:id, :line_one, :line_two, :city, :state, :zip, :customer_id)
    end
end