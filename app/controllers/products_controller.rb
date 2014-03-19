class ProductsController < InheritedResources::Base
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def show
		@product = Product.find(params[:id])
		@products = Product.find(params[:id])
	end

	def edit  
	    @product = Product.find(params[:id])  
	    respond_with(@product)  
	  end 

	  def create
	    @product = Product.new(product_params)
	    if @product.save
	      redirect_to @product
	    else
	      render action: 'new'
	    end
	  end

	def update  
	  @product = Product.find(params[:id])  
	  if @product.update_attributes(params[:product])  
	    # flash[:notice] = "Successfully updated customer."  
	  end  
	  respond_with(@product)  
	end  

	def product_params
      params.require(:product).permit(:id, :style, :color, :quantity, :xs, :small, :medium, :large, :xl, :xxl, :xxxl, :ivxl, :vxl, :vixl)
    end
end