class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :account
  validates :email, uniqueness: true, presence: true
  has_many :customers
  has_many :orders

  ROLES = %w(admin sales broker production)

  def role?(permission)
    self.role == permission.to_s.downcase
  end

  def superadmin?
    role? :superadmin
  end

  def accountadmin?
    role? :accountadmin
  end

  def admin?
    role? :accountadmin
  end

  def sales?
    role? :sales
  end

  def broker?
    role? :broker
  end

  def production?
    role? :production
  end

  ###Braintree###
  after_destroy :destroy_customer

  def braintree_customer
    braintree_customer_id && BraintreeRails::Customer.new(braintree_customer_id)
  end

  def braintree_subscription
    braintree_customer.credit_cards.first.subscriptions.first
  end

  private
  def destroy_customer
    BraintreeRails::Customer.delete(braintree_customer_id) if braintree_customer_id.present?
  end
end