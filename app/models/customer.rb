class Customer < ActiveRecord::Base
	has_many :orders
	belongs_to :account
	belongs_to :user
end
