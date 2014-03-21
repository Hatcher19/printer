class Order < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	has_many :products
	has_many :artworks
	accepts_nested_attributes_for :products, :allow_destroy => true
	accepts_nested_attributes_for :artworks, :allow_destroy => true

	STATUS = %w(new approved complete cancelled hold)
	ARTSTATUS = %w(pending approved)
	PRODUCTSTATUS = %w(Purchase Ordered Partial Received)
	CATEGORY = %w(Screenprint Embroidery DTG Heatpress)
    TYPE = %w(New Re-order)
    SHIP = %w(true false)
end
