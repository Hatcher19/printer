class AddAccountIdAndUserIdAndOrderIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :account_id, :integer
    add_column :customers, :user_id, :integer
    add_column :customers, :order_id, :integer
  end
end
