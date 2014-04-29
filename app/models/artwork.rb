class Artwork < ActiveRecord::Base
	belongs_to :orders
	mount_uploader :file, ArtworkUploader
	LOCATION = %w(Front Back Chest(L) Chest(R) Sleeve(L) Sleeve(R) Leg(L) Leg(R) Pocket(L) Pocket(R) Hat(front) Hat(back)  )
end
