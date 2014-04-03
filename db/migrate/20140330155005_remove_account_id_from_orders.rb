class RemoveAccountIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :account_id, :integer
  end
end
