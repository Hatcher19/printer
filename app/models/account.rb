class Account < ActiveRecord::Base
	has_many :orders
	has_many :customers
	has_many :users
	accepts_nested_attributes_for :users, :allow_destroy => true
end
