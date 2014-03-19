class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :products
	accepts_nested_attributes_for :products, :allow_destroy => true

	STATUS = %w(new approved complete cancelled hold)
	ARTSTATUS = %w(pending approved)
	PRODUCTSTATUS = %w(Purchase Ordered Partial Received)
	CATEGORY = %w(Screenprint Embroidery)
    TYPE = %w(New Re-order)
end
