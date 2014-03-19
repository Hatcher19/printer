class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         belongs_to :account
         # validates_uniqueness_of :email, :allow_blank => false
         has_many :customers
         has_many :orders
end
