class OrdersController < InheritedResources::Base
	#devise user authentication. 
	before_filter :authenticate_user!

	def index
		@orders = Order.all
	end

	def new
		@order = Order.new
		# @order.line_items.build
		# @order.artworks.build
	end

	def show
		@order = Order.find(params[:id])
	end

	def edit  
	    @order = Order.find(params[:id])  
	    respond_with(@order)  
	  end 

	  def create
	    @order = Order.new(order_params)
	    if @order.save
	      redirect_to @order, notice: 'Order was successfully created.'
	    else
	      render action: 'new'
	    end
	  end

	def update  
	  @order = Order.find(params[:id])  
	  if @order.update_attributes(params[:order])  
	    flash[:notice] = "Successfully updated order."  
	  end  
	  respond_with(@order)  
	end  

	def order_params
      params.require(:order).permit(:id, :name, :product_status, :end_date, :category, :ship, :order_type, :order_status, :art_status, :customer_id)
end