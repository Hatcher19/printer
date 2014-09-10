class Customer < ActiveRecord::Base
	has_many :orders
	belongs_to :account
	belongs_to :user
	has_many :addresses
	accepts_nested_attributes_for :addresses, :allow_destroy => true
	validates :organization, uniqueness: true, presence: true
	validates :customer_name, presence: true
	validates :customer_email, presence: true
	validates :customer_phone, uniqueness: true, presence: true
end
