class RemoveAccountIdFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :account_id, :integer
  end
end
