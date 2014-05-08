class RemovePlanIdAndStripeCardTokenAndStripeCustomerTokenAndEmailFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :plan_id, :integer
    remove_column :accounts, :stripe_card_token, :string
    remove_column :accounts, :stripe_customer_token, :string
    remove_column :accounts, :email, :string
  end
end
