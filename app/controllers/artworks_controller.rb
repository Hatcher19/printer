class ArtworksController < InheritedResources::Base
	def index
		@artworks = Artwork.all
	end

	def new
		@artwork = Artwork.new
	end

	def show
		@artwork = Artwork.find(params[:id])
		@artworks = Artwork.find(params[:id])
	end

	def edit  
	    @artwork = Artwork.find(params[:id])  
	    respond_with(@artwork)  
	  end 

	  def create
	    @artwork = Artwork.new(artwork_params)
	    if @artwork.save
	      redirect_to @artwork
	    else
	      render action: 'new'
	    end
	  end

	def update
		@artwork = Artwork.find(params[:id])	
		respond_to do |format|	
			if @artwork.update_attributes(artwork_params)
				format.json { respond_with_bip(@artwork) }
			else
				format.html { render action: "edit" }
				format.json { respond_with_bip(@artwork) }
			end
		end
	end  

	def artwork_params
      params.require(:artwork).permit(:id, :artwork, :color, :location)
    end
end