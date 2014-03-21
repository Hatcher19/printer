class OrdersController < InheritedResources::Base
	#devise user authentication. 
	before_filter :authenticate_user!

	def index
		@search = Order.search(params[:q])
		@orders = @search.result
		@search.build_condition if @search.conditions.empty?
	end

	def new
		@order = Order.new
		@order.products.build
		@order.artworks.build
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
        params.require(:order).permit(:id, :name, :product_status, :end_date, :category, :ship, :order_type, :order_status, :art_status, :customer_id, :user_id,
      								  :products_attributes => [:id, :style, :color, :quantity, :xs, :small, :medium, :large, :xl, :xxl, :xxxl, :ivxl, :vxl, :vixl],
      								  :artworks_attributes => [:id, :file, :color, :location])
	end
end