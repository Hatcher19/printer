class OrdersController < InheritedResources::Base
	respond_to :html, :json
	#devise user authentication. 
	before_filter :authenticate_user!
	before_filter :new_order, :only => [:new, :create]

	load_and_authorize_resource

	def new_order
		@order = Order.new(order_params)
	end

	def index
		@search = current_user.account.orders.search(params[:q])
		@orders = @search.result(:distinct => true) 
		if params[:account_id_eq] && params[:account_id_eq]!=''  
		  @q.build_grouping({:m => 'or', :account_id_eq => params[:account_id_eq], :account_id_null => true})  
		end
		 # @orders = current_user.account.orders.all 
	end

	def new
		@order = Order.new
		@order.products.build
		@order.artworks.build
	end

	def show
		@order = Order.find(params[:id])
		@address = Address.find_by(:ship_type => 'shipping')
	end

	def edit  
	    @order = Order.find(params[:id])   
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
		respond_to do |format|	
			if @order.update_attributes(order_params)
				format.json { respond_with_bip(@order) }
			else
				format.html { render action: "edit" }
				format.json { respond_with_bip(@order) }
			end
		end
	end 

	def order_params
        params.fetch(:order).permit(:uuid, :id, :name, :product_status, :end_date, :category, :shipping, :order_type, :order_status, :art_status, :customer_id, :user_id, :account_id, :_destroy,
      								  :products_attributes => [:id, :style, :color, :quantity, :xs, :small, :med, :large, :xl, :xxl, :xxxl, :ivxl, :vxl, :vixl],
      								  :artworks_attributes => [:id, :file, :color, :location]) if params[:order]
	end

	def orders_filter
    respond_to do |format|
      format.html
      format.js
    end

    def history
	  @versions = PaperTrail::Version.order('created_at DESC')
	end
  end
end