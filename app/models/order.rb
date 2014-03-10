class Order < ActiveRecord::Base

	STATUS = %w(new approved complete cancelled hold)
	ARTSTATUS = %w(pending approved)
	PRODUCTSTATUS = %w(Purchase Ordered Partial Received)
	CATEGORY = %w(Screenprint Embroidery)
    TYPE = %w(New Re-order)
end
