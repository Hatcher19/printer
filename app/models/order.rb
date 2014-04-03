class Order < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	belongs_to :account
	has_many :products
	has_many :artworks
	accepts_nested_attributes_for :products, :allow_destroy => true
	accepts_nested_attributes_for :artworks, :allow_destroy => true

	STATUS = %w(new approved complete cancelled hold)
	ARTSTATUS = %w(pending approved)
	PRODUCTSTATUS = %w(purchase ordered partial received)
	CATEGORY = %w(screenprint embroidery DTG heatpress)
    TYPE = %w(New Re-order)
    SHIP = %w(true false)
end
