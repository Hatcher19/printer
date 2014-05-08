class RemoveStripCustomerTokenFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :strip_customer_token, :string
  end
end
